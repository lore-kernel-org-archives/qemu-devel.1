Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668AA252BA
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668AA252BA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNMt-0006Kc-4M
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSNLW-00052G-9K
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:40:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:63839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSNLM-0004Lj-JE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:40:16 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6EE99747601;
 Tue, 13 Oct 2020 18:40:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E68A77475FA; Tue, 13 Oct 2020 18:40:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E4E7C7475FF;
 Tue, 13 Oct 2020 18:40:03 +0200 (CEST)
Date: Tue, 13 Oct 2020 18:40:03 +0200 (CEST)
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 04/10] meson: option to build as shared library
In-Reply-To: <20201013155757.GR70612@redhat.com>
Message-ID: <9d737fc-809-b1b3-f42e-45d8cfbfbd6e@eik.bme.hu>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-5-j@getutm.app> <20201013075104.GA70612@redhat.com>
 <e27acf2-4dbe-4674-78cc-67aa7b505c54@eik.bme.hu>
 <20201013144625.GP70612@redhat.com>
 <CA+E+eSBu_LOnQ=B+N7vm3H2zkBxey8z_T1V0JpSU8rZND6GRYQ@mail.gmail.com>
 <20201013155757.GR70612@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-182845050-1602606743=:37098"
Content-ID: <ee18c0a1-def-e6e5-bea5-a32d1a14fa95@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-182845050-1602606743=:37098
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <bdf0910-a96a-9e13-7434-eb87a1fb978f@eik.bme.hu>

On Tue, 13 Oct 2020, Daniel P. Berrangé wrote:
> On Tue, Oct 13, 2020 at 08:16:46AM -0700, Joelle van Dyne wrote:
>> I will start a separate conversation of UTM's license compatibility.
>>
>> Regarding the patch, would some sort of warning message in configure
>> (if building as a shared library) regarding the license be wise? Or
>> would it pollute the output logs?
>
> I think there's also a more fundamental question of whether this is
> a concept we actually want to support at all.

Discussing other compelling reasons for doubt is OK, just wanted to avoid 
having this dismissed on possible licensing problems only. I still think 
it would be a good idea to support QEMU on iOS but due to the (mostly 
security related) limitations of that platform some compromises my be 
needed. Please consider it instead of being quick to decide to avoid these 
problems by not taking the patches upstream which is a convenient solution 
from QEMU viewpoint but not helping other projects. (Other platforms may 
come up in the future with similar limitations that iOS has as more 
desktop OSes also move in the same direction to increase security so these 
may need to be handled anyway at one point, iOS is a good test case for 
that.)

> IIUC, this shared library just exposes a "qemu_main" method which
> the external app has to jump into. IOW, the "char **argv" parameter
> to qemu_main becomes the ELF library ABI.  Declaring this a shared
> library interface is a non-negligible commitment for QEMU maintainers,
> especially given that there is alot about QMEU's command line parsing
> that maintainers do not like and wish to change.

Given that libvirt uses the command line instead of a proper API 
currently, this is not worse than that. If there was a better API or there 
will be one in the future, the shared lib API can be changed the same way 
as libvirt will need to be adapted for that but it's not reasonable to 
demand these patches to come up with that API now. So for now this seems 
to be acceptable and does not prevent cleaning it up later together with 
the planned changes you mentioned. Compatibility for the command line will 
have to be maintained until a better API is devised for use by other 
software like libvirt and anyone intending to use it as dll so this does 
not seem like added commitment.

> There is a further question about whether we want to commit to an
> architectural model where  fork() is not something we can use. A

Does Windows support fork()? I think we're already committed to support 
Windows so any solution you'll come up with will have the same problem 
anyway. So I think this does not add additional restriction that we don't 
already have either.

Regards,
BALATON Zoltan
--3866299591-182845050-1602606743=:37098--

