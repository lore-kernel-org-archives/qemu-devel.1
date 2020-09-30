Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEF8C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9EF20754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URR2n2gQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9EF20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeMj-0001gg-L9
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kNeL4-0000Uy-5d
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:48:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kNeKy-0000px-P4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:48:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UFjpKZ169654;
 Wed, 30 Sep 2020 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=O0VuLju++VkJumLI+B42TDAzBI1DcJeKBE7BidKh0ig=;
 b=URR2n2gQEYNcM+3QyC6cQn/72LJMuHnNpd2ThE/GVNRcNPpzPWqWoPIRN7CQHlutezU1
 tb9ahuzWV4Ty8gc1ADQ33FDSqOk6d6l5oxDqSgVwPYuEHHPteEngvzFnXtjO1DXRiUGY
 YWOePmLGrljUdg0XKCkskWKCx93sKfvtKtq/geRaBso8/3Sdzc36QUnZ3tWmLWBaQFLw
 ZMkYCkDtUMpCljTP8+PWRUhBKV58PwHk/vxBGqCkP83iUL2vUcoEX/yX85j045KFik0f
 j9MkEsUj/xH6fNp/8wctY6D1NrvZqTSTN2W4WyEBbQ3SGcD3zx/wW+Z/Pe+pAaAMEgoa qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 33su5b1cnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 15:48:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UFkUlq148209;
 Wed, 30 Sep 2020 15:48:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 33tfj0a961-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 15:48:05 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08UFm4ou024314;
 Wed, 30 Sep 2020 15:48:04 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 08:48:04 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 46E2A18C7E1F; Wed, 30 Sep 2020 16:48:02 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: P J P <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv>
Date: Wed, 30 Sep 2020 16:48:02 +0100
Message-ID: <m2362z8dvx.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1031 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300124
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=darren.kenny@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 11:48:08
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Prasad,

Just my 2c as someone working on a downstream distro with Qemu...

On Friday, 2020-09-18 at 12:32:23 +0530, P J P wrote:
>   Hello all,
>
> +-- On Wed, 16 Sep 2020, Stefan Hajnoczi wrote --+
> | I'm surprised the lack of encryption doesn't bother you. The security bug 
> | reporting process should be confidential to prevent disclosure of 0-days.
>
> * I think it'll work only if all issue reports are encrypted. Under current 
>   process, we've our GPG keys published, yet majority of the issue reports are 
>   unencrypted. CVEs are of more interest/incentive.
>
> * Encrypted email workflow is also not as seamless as unencrypted.
>

While that is true, some aliases have managed to do something here by
having a single key for the alias, and behind the scenes that
re-encrypts the e-mail for each member of that alias (trying to avoid
the 'list' term a little here)

An example of this is the 'distro's list, e.g.:

- https://oss-security.openwall.org/wiki/mailing-lists/distros

>
> | Triaging and fixing are different things. Where is the bottleneck, triaging 
> | or fixing?
>
> * Issue triaging/analysis is lesser time; Patches may take longer, so fixing.
>
> * But having mailing-list isn't going to affect/address either.
>
>
> | Do downstream maintainers want to know about potential security bug reports 
> | that have not been triaged yet?
> | 
> | Maybe there should there be a pre-announce list for bugs that have been 
> | triaged? That saves downstream from being spammed with confidential info 
> | that they probably can't use.
>
> * I was thinking about that, an '-announce' list could be better. Because 
>   issue reports may come with reproducers (code/scripts/packet dump). And 
>   sharing such reproducers with wide-rs recipients seems risky, not right.
>
> * Such reproducers shall stay in the list archives forever. It may have some 
>   legal IP related concerns. I'm not sure.

I believe there was some resistance in the Linux kernel security space
of having things like a pre-announce message of a security issue that
has come in but is not fixed yet...

If you're looking to announce before a security issue is fixed, it
may just be better to keep it to the qemu-security members, which should
try to include at least 1, if not more, members from interested distros.
I know from past kernel security issues, it is still important to a
distro to be able to reproduce any issues if a PoC is provided.

There are some existing mechanisms for announcing security issues once
found, e.g. oss-security:

- https://oss-security.openwall.org/wiki/mailing-lists/oss-security

A lot of distros have people on this list already monitoring it and many
OSS projects do send announcements of CVEs and security issues to this,
once resolved and an embargo period has expired - including Qemu, as I'm
sure that you know, given I've seen postings from you (Prasad) there.

Why would this not be enough for that?

> | I don't think a broadcast model works well for assigning responsibility. If 
> | maintainers constantly receive security-related emails (most of which don't 
> | affect them), they will ignore them. This is what happens with broadcast CI 
> | and fuzzing results.
> | 
> | Instead someone should assign security bug reports to relevant maintainers.
> | 
> | Another option is to let reporters directly contact the maintainers (e.g. 
> | QEMU's MAINTAINERS file), but this is hard to get right and if a maintainer 
> | is on vacation the report may go unnoticed.
>
> * True, agree.
>
>  
> | Anyway, it's unclear to me what the motivation for creating a list and
> | changing the process is. Please share your goals and reasoning in more
> | detail.
>
> * Primary motivation is to address the concern that current process limits 
>   community participation.
>
> * Representatives from downstream QEMU user communities shall be notified 
>   about security issues as and when they come in.
>
> * These representatives then decide if an issue can be readily disclosed and 
>   discussed on the public 'qemu-devel' list OR needs to go through an embargo 
>   process.

These are all very important points - and the need for an embargo period
can be vital where Qemu/KVM is being widely deployed in a company.

>
>
> | I think it's worth investigating whether GitLab Issues can be configured in 
> | a secure-enough way for security bug reporting. That way HTTPS is used and 
> | only GitLab stores the confidential information (this isn't end-to-end 
> | encryption but seems better than unencrypted SMTP and plaintext emails 
> | copied across machines).
>
> +-- On Wed, 16 Sep 2020, Peter Maydell wrote --+
> | Given that we currently use launchpad for bugs we should also look at 
> | whether launchpad's "private security" bug classification would be useful 
> | for us (currently such bug reports effectively go to /dev/null but this can 
> | be fixed).
>
>
> * Bug trackers would entail that reporters must have an account there. They 
>   may create account also, but if/when they become inactive, they'll continue
>   to  receive emails or have access to security bugs.
>
>   A mailing list works more on invite-only basis that way.
>
> * Bug trackers may also face the current limitation of community participants 
>   not knowing about the issues as and when they come in.
>
> * So bug trackers need a way to send an email to a -announce/-security list,
>   sans the reproducer code/scripts/packet dump etc. information.
>
> * Between LaunchPad and GitLab, I think GitLab is preferable.
>

I would agree that Gitlab may be better here, if it would work - Gitlab
can certainly be configured to restrict access to specific projects, but
I'm not sure how that would play into logging an issue if you can't even
see the project in question as a non-member of the security team.

But I don't really know the internal workings of Gitlab, maybe there is
a way to do it.

Thanks,

Darren.



