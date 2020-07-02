Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5073C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7288A206BE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="I7Ql+ZXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7288A206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1rw-0002vF-5X
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jr1k4-0004Ou-3w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:07:16 -0400
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:38380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jr1k2-0002K3-2V
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593706034; bh=q9EhfTTKRbL2tCcgskxr1lRe8Zd/JsyrbSmU
 +9bWWec=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=I7Ql+ZX
 WMdO/6G/97wDB0Ix/g0Ny+T39COPTJaGmyXMec+x3xT2bpuwQCmUM+x9Y3EXIeNM9NO
 PNwyTS79HO26HNxO6XC9+M8myWW5KyxnJhNxEocB2XO89tuGPrTQcNhTtGx9CcbkJPk
 cXIGB63jydjuscKpHtoPIVNDD9pwPdFn1EKSUKRS+WtKXEdY+8FAxoG+5VnpKlwayNC
 /P1A4LBppBHWtUiyIqRrVOBm/jlSBkUzppSknr4+KIc6ACCl24iROWIFev9+BjG47O2
 NYNb87/jM3pbDGajOVIWFOiMWxXNp+n7CCAkZPOqxEYYPgwPzi//7rQHOaKpGtq2h9Q
 ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=Vxa69QFyf1BBh2ZdurMf++0yuheArNXpyfd6bMMw0san+r+2XlmLxvuwCBaubf3F+l3DXTlkc7VJASSVtTEIuZTHhApuOqKfih9x5kFJP4nN04nXIpoSO9Hqz+SHkJUyX+heTDUQ8aTna8yer5gi8vu30MISFL23YMQA1fhlfE1nWEQ5OSHjLu888myM0cKwKw24NbU20pmw4zKNoaOv9/NuUpXpZ0GYxQSz9uX/S5cLtpNujebuwCVLLwmMvb04JeCYgwPTeThEYyO4l4co1B5g7ybc9FwZ4FtJUbB1vRkzMwPXXRKv4mXuV5Zvr5Zm33eD+YqZLYnwUIv4x4Gz4g==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jr1jx-0006O6-FX; Thu, 02 Jul 2020 12:07:09 -0400
Message-ID: <5EFE062C.6080303@mindspring.com>
Date: Thu, 02 Jul 2020 12:07:08 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: =?UTF-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Subject: Re: [PATCH] configure / util: Auto-detect the availability of
 openpty()
References: <20200702143955.678-1-thuth@redhat.com>
 <20200702144650.GM1888119@redhat.com>
In-Reply-To: <20200702144650.GM1888119@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca59609ab0370624f8f9cc07c136eb08ff1350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.64; envelope-from=denber@mindspring.com;
 helo=elasmtp-curtail.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:07:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Tribble <peter.tribble@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 07/02/20 10:46, Daniel P. Berrangé wrote:
> On Thu, Jul 02, 2020 at 04:39:55PM +0200, Thomas Huth wrote:
>> Recent versions of Solaris (v11.4) now feature an openpty() function,
>> too, causing a build failure since we ship our own implementation of
>> openpty() for Solaris in util/qemu-openpty.c so far. Since there are
>> now both variants available in the wild, with and without this function,
>> let's introduce a proper HAVE_OPENPTY define for this to fix the build
>> failure.
> 11.4 has been out since Aug 2018
>
> The previous verison of solaris  11.3 was from Oct 2015, with EOL
> in Oct 2020 [1].
>
> Solaris isn't an officially supported platform for QEMU, but if it
> was, then we'd probably consider it a long life distro, and thus
> consider 11.3 to be out of scope for QEMU by now.
>
> IOW, instead of checking for openpty being missing, I think there's
> a decent argument to be made that we can just assume openpty exists,
> and delete the old solaris compat code entirely.
Of course there are still many people (where "many" is a relative term) 
running Solaris 10 for compatibility reasons and Solaris 10 does not 
have openpty.  The only real reason to run 11.3 is because it still has 
support for the Sun Ray thin client and that was removed from 11.4 
(which is a giant pain).  So I'm stuck running Solaris 10 in an LDOM to 
run all my old code and have Sun Ray access, and 11.4 in the control 
domain because it's the latest thing.

             - Michele


>
> Regards,
> Daniel
>
> [1] https://en.wikipedia.org/wiki/Solaris_(operating_system)
>

