Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62480C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33B321852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33B321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzSzw-00051y-32
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 17:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzSyY-0004Ge-DL
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzSyW-0008GN-Jn
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:44:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzSyW-0008FK-Cv
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:44:32 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A8D999D2E
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 21:44:31 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id h8so4200331wrb.11
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 14:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h2xzjSFZNTWlCffgvGmqesSJuEHPH52iwk5nP49KPQY=;
 b=cHta4UqUw7EQrxh3RCtf3VcTGL9fcCGvlq0Vsz6WlI/U4ia5Fs20XDQI4BLseNddB0
 vmqxYfkiwemA3lO1U0sJJkP5evEuhJ/9PCze9DAe5RWw3OnI+FXt8pVh1qZBCkHZtkdk
 4FXJRfh+ShqR3fQnZ++uLwUUtRN6vyZgebOmJoxWZq4dHmDbCHehYKjh1Hb9rBt+5NGJ
 2tAlJQRM7SsS6Ci881/AbGaQZVJHrkxZSmnpWTrOI0dnfgFtmQqQox0ESuqcFyQY8/Dp
 p0i1cWDlAH+OYjA/wx7G4QCuxY87kCo7DfDa6X5SLfpfzU0IxTZDn+x+EYnPVvFsztok
 uKSA==
X-Gm-Message-State: APjAAAUMpf1CMHgStrDeyxCr6uMPLIxtCYzj+pBpT+vsSXK+z1lh+9TA
 Kd9f0tXocjNwCpwVll6uuUlTW5liSh6QoaD7p1O/+gh/6Vvsyh8nMU1RE8FmX7hgRTCP2D3H8Ma
 boBPwIRfUACLPYLA=
X-Received: by 2002:adf:edc9:: with SMTP id v9mr22550679wro.125.1566164669527; 
 Sun, 18 Aug 2019 14:44:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyq1v4DfCMJNoAeYMrQK7nrdjPPaAOfkuNduzjgjCwxae6Z6aJ5i74L3JJILhmb7zElm7rP7A==
X-Received: by 2002:adf:edc9:: with SMTP id v9mr22550609wro.125.1566164669299; 
 Sun, 18 Aug 2019 14:44:29 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f18sm13122174wrx.85.2019.08.18.14.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2019 14:44:28 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565940633026.69822@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3872a5ec-ccf1-2978-34b5-b0b5478d2b86@redhat.com>
Date: Sun, 18 Aug 2019 23:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565940633026.69822@bt.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 11/42] memory: Access MemoryRegion with
 MemOp
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, jasowang@redhat.com,
 jiri@resnulli.us, ehabkost@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, andrew@aj.id.au,
 claudio.fontana@suse.com, crwulff@gmail.com, laurent@vivier.eu,
 sundeep.lkml@gmail.com, michael@walle.cc, qemu-ppc@nongnu.org,
 kbastian@mail.uni-paderborn.de, imammedo@redhat.com, fam@euphon.net,
 peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, amarkovic@wavecomp.com,
 peter.chubb@nicta.com.au, aurelien@aurel32.net, pburton@wavecomp.com,
 sagark@eecs.berkeley.edu, green@moxielogic.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, robh@kernel.org,
 borntraeger@de.ibm.com, joel@jms.id.au, antonynpavlov@gmail.com,
 chouteau@adacore.com, lersek@redhat.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/19 9:30 AM, tony.nguyen@bt.com wrote:
> Convert memory_region_dispatch_{read|write} operand "unsigned size"
> into a "MemOp op".
>=20
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> =C2=A0include/exec/memop.h =C2=A0| 20 ++++++++++++++------
> =C2=A0include/exec/memory.h | =C2=A09 +++++----
> =C2=A0memory.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
7 +++++--
> =C2=A03 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index dfd76a1..0a610b7 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -12,6 +12,8 @@
> =C2=A0#ifndef MEMOP_H
> =C2=A0#define MEMOP_H
> =C2=A0
> +#include "qemu/host-utils.h"
> +
> =C2=A0typedef enum MemOp {
> =C2=A0 =C2=A0 =C2=A0MO_8 =C2=A0 =C2=A0 =3D 0,
> =C2=A0 =C2=A0 =C2=A0MO_16 =C2=A0 =C2=A0=3D 1,
> @@ -107,14 +109,20 @@ typedef enum MemOp {
> =C2=A0 =C2=A0 =C2=A0MO_SSIZE =3D MO_SIZE | MO_SIGN,
> =C2=A0} MemOp;
> =C2=A0
> +/* MemOp to size in bytes. =C2=A0*/
> +static inline unsigned memop_size(MemOp op)
> +{
> + =C2=A0 =C2=A0return 1 << (op & MO_SIZE);
> +}
> +
> =C2=A0/* Size in bytes to MemOp. =C2=A0*/
> -static inline unsigned size_memop(unsigned size)
> +static inline MemOp size_memop(unsigned size)
> =C2=A0{
> - =C2=A0 =C2=A0/*
> - =C2=A0 =C2=A0 * FIXME: No-op to aid conversion of
> memory_region_dispatch_{read|write}
> - =C2=A0 =C2=A0 * "unsigned size" operand into a "MemOp op".
> - =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0return size;
> +#ifdef CONFIG_DEBUG_TCG
> + =C2=A0 =C2=A0/* Power of 2 up to 8. =C2=A0*/
> + =C2=A0 =C2=A0assert((size & (size - 1)) =3D=3D 0 && size >=3D 1 && si=
ze <=3D 8);

Easier to review as:

       assert(is_power_of_2(size) && size <=3D 8);

(This can be cleaned later).

> +#endif
> + =C2=A0 =C2=A0return ctz32(size);
> =C2=A0}
> =C2=A0
> =C2=A0#endif
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bb0961d..975b86a 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -19,6 +19,7 @@
> =C2=A0#include "exec/cpu-common.h"
> =C2=A0#include "exec/hwaddr.h"
> =C2=A0#include "exec/memattrs.h"
> +#include "exec/memop.h"
> =C2=A0#include "exec/ramlist.h"
> =C2=A0#include "qemu/queue.h"
> =C2=A0#include "qemu/int128.h"
> @@ -1731,13 +1732,13 @@ void mtree_info(bool flatview, bool
> dispatch_tree, bool owner);
> =C2=A0 * @mr: #MemoryRegion to access
> =C2=A0 * @addr: address within that region
> =C2=A0 * @pval: pointer to uint64_t which the data is written to
> - * @size: size of the access in bytes
> + * @op: size, sign, and endianness of the memory operation
> =C2=A0 * @attrs: memory transaction attributes to use for the access
> =C2=A0 */
> =C2=A0MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hwaddr addr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
uint64_t *pval,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uns=
igned size,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mem=
Op op,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
MemTxAttrs attrs);
> =C2=A0/**
> =C2=A0 * memory_region_dispatch_write: perform a write directly to the =
specified
> @@ -1746,13 +1747,13 @@ MemTxResult
> memory_region_dispatch_read(MemoryRegion *mr,
> =C2=A0 * @mr: #MemoryRegion to access
> =C2=A0 * @addr: address within that region
> =C2=A0 * @data: data to write
> - * @size: size of the access in bytes
> + * @op: size, sign, and endianness of the memory operation
> =C2=A0 * @attrs: memory transaction attributes to use for the access
> =C2=A0 */
> =C2=A0MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 hwaddr addr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 uint64_t data,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 un=
signed size,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Me=
mOp op,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 MemTxAttrs attrs);
> =C2=A0
> =C2=A0/**
> diff --git a/memory.c b/memory.c
> index 5d8c9a9..89ea4fb 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1439,9 +1439,10 @@ static MemTxResult
> memory_region_dispatch_read1(MemoryRegion *mr,
> =C2=A0MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hwaddr addr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
uint64_t *pval,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uns=
igned size,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mem=
Op op,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
MemTxAttrs attrs)
> =C2=A0{
> + =C2=A0 =C2=A0unsigned size =3D memop_size(op);
> =C2=A0 =C2=A0 =C2=A0MemTxResult r;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0if (!memory_region_access_valid(mr, addr, size, fal=
se, attrs)) {
> @@ -1483,9 +1484,11 @@ static bool
> memory_region_dispatch_write_eventfds(MemoryRegion *mr,
> =C2=A0MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 hwaddr addr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 uint64_t data,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 un=
signed size,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Me=
mOp op,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 MemTxAttrs attrs)
> =C2=A0{
> + =C2=A0 =C2=A0unsigned size =3D memop_size(op);
> +
> =C2=A0 =C2=A0 =C2=A0if (!memory_region_access_valid(mr, addr, size, tru=
e, attrs)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unassigned_mem_write(mr, addr, data, =
size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MEMTX_DECODE_ERROR;
> --=C2=A0
> 1.8.3.1
>=20
> =E2=80=8B
>=20
>=20

