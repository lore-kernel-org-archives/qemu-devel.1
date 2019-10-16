Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B9FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 10:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EB32168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 10:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EB32168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKgkU-0005E9-Ho
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 06:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chouteau@adacore.com>) id 1iKgdu-0000Ew-6A
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chouteau@adacore.com>) id 1iKgdt-00074Q-0U
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:34:58 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:46977
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chouteau@adacore.com>)
 id 1iKgds-000749-RE
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:34:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id D2B69814FA;
 Wed, 16 Oct 2019 12:34:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vRtHuprBph8c; Wed, 16 Oct 2019 12:34:54 +0200 (CEST)
Received: from [192.168.0.24] (89-157-139-225.rev.numericable.fr
 [89.157.139.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 652CB8139B;
 Wed, 16 Oct 2019 12:34:54 +0200 (CEST)
Subject: Re: LEON3 networking
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Joshua Shaffer <joshua.shaffer@astrobotic.com>, qemu-devel@nongnu.org,
 Jiri Gaisler <jiri@gaisler.se>, KONRAD Frederic
 <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <CAPJW7GKLH3pkrGQQj_OaAy0UecUJttsHOJp35+CcpZvm9cM2WQ@mail.gmail.com>
 <6bb8abb2-68f0-db85-1557-6e04839b5ea2@redhat.com>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <32c38984-e745-de6c-792e-09910b68cedd@adacore.com>
Date: Wed, 16 Oct 2019 12:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6bb8abb2-68f0-db85-1557-6e04839b5ea2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.98.77.210
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello people,

On 15/10/2019 18:57, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Joshua,
>=20
> On 10/15/19 3:17 PM, Joshua Shaffer wrote:
>> Hello,
>>
>> I've been using the LEON3 port of qemu, and am wondering if anyone has=
 touched the networking setup for such since the thread here: https://lis=
ts.rtems.org/pipermail/users/2014-September/028224.html
>=20
> Thanks for sharing this!
>=20
> Good news, Jiri keeps rebasing his patch with the latest stable version=
.
> Bad news, he didn't not signed his work with a "Signed-off-by" tag so w=
e can not take this as it into the mainstream repository, see https://wik=
i.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off=
-by:_line
>=20

The Gaisler patches have been rewrote by my colleague Frederic (in CC) an=
d they are now in mainstream.
(see https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03869.html)

But none of them are implementing network support, and I never heard of s=
omeone working on network for leon3.

Regards,


