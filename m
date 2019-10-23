Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F50CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8722064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8722064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gaisler.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNN8F-0004Hb-OV
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 16:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiri@gaisler.se>) id 1iNMis-000224-Er
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiri@gaisler.se>) id 1iNMiq-0005KC-Qp
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:55:10 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:22983)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiri@gaisler.se>) id 1iNMiq-0005Jl-2I
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:55:08 -0400
X-Halon-ID: ec5a13d4-f5ce-11e9-bdc3-005056917a89
Authorized-sender: jiri@gaisler.se
Received: from [192.168.9.107] (unknown [92.33.136.219])
 by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPSA
 id ec5a13d4-f5ce-11e9-bdc3-005056917a89;
 Wed, 23 Oct 2019 21:54:31 +0200 (CEST)
Subject: Re: LEON3 networking
From: Jiri Gaisler <jiri@gaisler.se>
To: Joshua Shaffer <joshua.shaffer@astrobotic.com>,
 Fabien Chouteau <chouteau@adacore.com>
References: <CAPJW7GKLH3pkrGQQj_OaAy0UecUJttsHOJp35+CcpZvm9cM2WQ@mail.gmail.com>
 <6bb8abb2-68f0-db85-1557-6e04839b5ea2@redhat.com>
 <32c38984-e745-de6c-792e-09910b68cedd@adacore.com>
 <CAPJW7GLOTyjdMozrb+TSnqpEyoiFh2sxZjYkLXx2pz2_J_dPgA@mail.gmail.com>
 <a6783ce6-eea2-214f-7dbd-7224e830db0b@gaisler.se>
Message-ID: <2ea63643-5cb2-017e-8889-bb8c77fd75cf@gaisler.se>
Date: Wed, 23 Oct 2019 21:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a6783ce6-eea2-214f-7dbd-7224e830db0b@gaisler.se>
Content-Type: multipart/mixed; boundary="------------EA0E40AF1CCD503B17540F97"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 195.74.38.227
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------EA0E40AF1CCD503B17540F97
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

BTW, here is a patch that you might want to apply to qemu if you intend
to run RTEMS on leon3. The plug&play area must support byte accesses,
which is used by the RTEMS grlib scanning functions...

Jiri.

On 10/23/19 8:37 PM, Jiri Gaisler wrote:
> Leon3 uses the GRETH ethernet IP core for networking. You would need to
> write a qemu emulation model of it to get networking support. The GRETH
> is fairly well described in the GRLIB IP manual, so it should not be
> impossible. The core is also available in open-source (VHDL) if you need
> to look up some finer details ... :-)
>
> Jiri.
>
> On 10/23/19 6:59 PM, Joshua Shaffer wrote:
>> Does anyone know what needs implemented to get networking supported?
>>
>> Joshua
>>
>> On Wed, Oct 16, 2019 at 6:34 AM Fabien Chouteau <chouteau@adacore.com> wrote:
>>> Hello people,
>>>
>>> On 15/10/2019 18:57, Philippe Mathieu-Daudé wrote:
>>>> Hi Joshua,
>>>>
>>>> On 10/15/19 3:17 PM, Joshua Shaffer wrote:
>>>>> Hello,
>>>>>
>>>>> I've been using the LEON3 port of qemu, and am wondering if anyone has touched the networking setup for such since the thread here: https://lists.rtems.org/pipermail/users/2014-September/028224.html
>>>> Thanks for sharing this!
>>>>
>>>> Good news, Jiri keeps rebasing his patch with the latest stable version.
>>>> Bad news, he didn't not signed his work with a "Signed-off-by" tag so we can not take this as it into the mainstream repository, see https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line
>>>>
>>> The Gaisler patches have been rewrote by my colleague Frederic (in CC) and they are now in mainstream.
>>> (see https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03869.html)
>>>
>>> But none of them are implementing network support, and I never heard of someone working on network for leon3.
>>>
>>> Regards,
>>>

--------------EA0E40AF1CCD503B17540F97
Content-Type: text/x-patch;
 name="qemu-4.1.0-leon3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="qemu-4.1.0-leon3.patch"

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index 7338461694..eaaedbfbcc 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -228,6 +228,9 @@ static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsigned size)
 {
     APBPnp *apb_pnp = GRLIB_APB_PNP(opaque);
 
+    if (size != 4)
+        return apb_pnp->regs[offset >> 2] >> ((~offset & 3) * 8);
+
     return apb_pnp->regs[offset >> 2];
 }
 

--------------EA0E40AF1CCD503B17540F97--

