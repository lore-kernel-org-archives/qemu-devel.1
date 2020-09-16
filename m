Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CFC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435E72245C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRRkhkHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435E72245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZlq-0000QW-V2
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIZkI-0007Dw-0s
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:53:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIZkC-00033a-Tj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600271595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIlTES1g24RSOmPR8981LEkwf+VWH4L7JhZ45ApJbfA=;
 b=TRRkhkHyzkig55OOKqfiXTkGZm7zxh9kplQOTYELz4LuEgs3niUmkdGy3wddzk4OISvosE
 Vqm2OKzb/dhnOgRL2KFGB/uDN+Jga34rpAS8Va28X7VJCt+1jnCtIowe3p62GN4BVQu1j0
 WzrWjGDFeJCNV2Um2vZwM10w2X46ShU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-CwWUPmeiOeSqwfqeUdhpOg-1; Wed, 16 Sep 2020 11:53:13 -0400
X-MC-Unique: CwWUPmeiOeSqwfqeUdhpOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 073B256BE3;
 Wed, 16 Sep 2020 15:53:12 +0000 (UTC)
Received: from gondolin (ovpn-115-151.ams2.redhat.com [10.36.115.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7067878809;
 Wed, 16 Sep 2020 15:53:02 +0000 (UTC)
Date: Wed, 16 Sep 2020 17:53:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v6 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Message-ID: <20200916175300.5c2b6bbb.cohuck@redhat.com>
In-Reply-To: <20200915194416.107460-1-walling@linux.ibm.com>
References: <20200915194416.107460-1-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 11:53:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, sumanthk@linux.ibm.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 15:44:08 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> Changelog:
>=20
>     v6
>=20
>     =E2=80=A2 sccb_verify_boundary function:
>         =E2=80=A2 s/len/sccb_len
>         =E2=80=A2 removed the endian check/conversion of the sccb_len fro=
m within=20
>           this function (caller is now responsible)
>=20
>     =E2=80=A2 proper endian conversion when using header length to malloc
>=20
>     =E2=80=A2 use g_autofree for work_sccb
>=20
>     =E2=80=A2 added r-b's and acks (thanks!)
>=20
>     =E2=80=A2 added a feature-check fence within the diag_318_handler to =
ensure
>         the handler does not complete without proper feature support
>         =E2=80=A2 will throw a program exception if handler is invoked bu=
t
>           feature is not enabled
>=20
>    =20
>=20
>     v5 (comment below pertains to version 5)
>=20
>     Janosch, Thomas, Conny: I've removed your r-b's from patch #3 since I
>     added some g_mallocs in place and I'd like to make sure things are
>     done properly there (explained in changelog, but let me know if furth=
er
>     explanation is necessary).
>=20
>     Janosch, please let me know if the changes to #3 are safe under PV.
>=20
>     Thanks.
>=20
>     =E2=80=A2 removed sccb_verify_length function
>         - will simply use the length check code that was in place before
>=20
>     =E2=80=A2 introduced a macro for calculating required SCCB length
>         - takes a struct and max # of cpus as args
>=20
>     =E2=80=A2 work_sccb size is now dynamically allocated based on the le=
ngth
>       provided by the guest kernel, instead of always using a static
>       4K size
>         - as such, the SCCB will have to be read twice:
>             - first time to retrieve the header
>             - second time with proper size after space for work_sccb=20
>               is allocated
>=20
>=20
>=20
>     v4
>    =20
>     =E2=80=A2 added r-b's and ack's (thanks, everyone!)
>=20
>     =E2=80=A2 renamed boundary and length function
>=20
>     =E2=80=A2 updated header sync to reflect a change discussed in the re=
spective
>         KVM patches
>=20
>     =E2=80=A2 s/data_len/offset_cpu
>=20
>     =E2=80=A2 added /* fallthrough */ comment in boundary check
>=20
>=20
>=20
>     v3
>=20
>     =E2=80=A2 Device IOCTLs removed
>         - diag 318 info is now communicated via sync_regs
>=20
>     =E2=80=A2 Reset code removed
>         - this is now handled in KVM
>         - diag318_info is stored within the CPU reset portion of the
>             S390CPUState
>=20
>     =E2=80=A2 Various cleanups for ELS preliminary patches
>=20
>=20
>=20
>     v2
>=20
>     =E2=80=A2 QEMU now handles the instruction call
>         - as such, the "enable diag 318" IOCTL has been removed
>=20
>     =E2=80=A2 patch #1 now changes the read scp/cpu info functions to
>       retrieve the machine state once
>         - as such, I have not added any ack's or r-bs since this
>           patch differs from the previous version
>=20
>     =E2=80=A2 patch #3 introduces a new "get_read_scp_info_data_len"
>       function in order clean-up the variable data length assignment
>       in patch #7
>         - a comment above this function should help clarify what's
>           going on to make things a bit easier to read
>=20
>     =E2=80=A2 other misc clean ups and fixes
>         - s/diag318/diag_318 in order to keep the naming scheme
>           consistent with Linux and other diag-related code
>         - s/byte_134/fac134 to align naming scheme with Linux
>=20
> -----------------------------------------------------------------------
>=20
> This patch series introduces two features for an s390 KVM quest:
>     - Extended-Length SCCB (els) for the Read SCP/CPU Info SCLP=20
>         commands
>     - DIAGNOSE 0x318 (diag_318) enabling / migration handling
>=20
> The diag 318 feature depends on els and KVM support.
>=20
> The els feature is handled entirely with QEMU, and does not require=20
> KVM support.
>=20
> Both features are made available starting with the zEC12-full model.
>=20
> These patches are introduced together for two main reasons:
>     - els allows diag 318 to exist while retaining the original 248=20
>         VCPU max
>     - diag 318 is presented to show how els is useful
>=20
> Full els support is dependant on the Linux kernel, which must react
> to the SCLP response code and set an appropriate-length SCCB.=20
>=20
> A user should take care when tuning the CPU model for a VM.
> If a user defines a VM with els support and specifies 248 CPUs, but
> the guest Linux kernel cannot react to the SCLP response code, then
> the guest will crash immediately upon kernel startup.
>=20
> Collin L. Walling (8):
>   s390/sclp: get machine once during read scp/cpu info
>   s390/sclp: rework sclp boundary checks
>   s390/sclp: read sccb from mem based on provided length
>   s390/sclp: check sccb len before filling in data
>   s390/sclp: use cpu offset to locate cpu entries
>   s390/sclp: add extended-length sccb support for kvm guest
>   s390/kvm: header sync for diag318
>   s390: guest support for diagnose 0x318
>=20
>  hw/s390x/event-facility.c           |   2 +-
>  hw/s390x/sclp.c                     | 142 ++++++++++++++++++++--------
>  include/hw/s390x/sclp.h             |  11 ++-
>  linux-headers/asm-s390/kvm.h        |   7 +-
>  linux-headers/linux/kvm.h           |   1 +
>  target/s390x/cpu.h                  |   2 +
>  target/s390x/cpu_features.h         |   1 +
>  target/s390x/cpu_features_def.h.inc |   4 +
>  target/s390x/cpu_models.c           |   1 +
>  target/s390x/gen-features.c         |   2 +
>  target/s390x/kvm.c                  |  47 +++++++++
>  target/s390x/machine.c              |  17 ++++
>  12 files changed, 194 insertions(+), 43 deletions(-)
>=20

Thanks, applied.


