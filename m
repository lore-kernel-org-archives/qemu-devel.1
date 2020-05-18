Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCADC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9A3207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9A3207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabZI-000724-1o
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jabYc-0006Ku-Um; Mon, 18 May 2020 04:55:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jabYb-00037N-Nm; Mon, 18 May 2020 04:55:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04I8Y9jb022327; Mon, 18 May 2020 04:55:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312cqkrutt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 04:55:31 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04I8odMQ075451;
 Mon, 18 May 2020 04:55:31 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312cqkrusf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 04:55:31 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04I8eBTi007767;
 Mon, 18 May 2020 08:55:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04fra.de.ibm.com with ESMTP id 3127t5shc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 08:55:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04I8tPk957212982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 08:55:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A016BA405B;
 Mon, 18 May 2020 08:55:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D50C3A405C;
 Mon, 18 May 2020 08:55:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.44.214])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 18 May 2020 08:55:24 +0000 (GMT)
Subject: Re: [PATCH v2 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-7-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d72f56c0-fed0-12ea-dfa6-f3441952a30e@linux.ibm.com>
Date: Mon, 18 May 2020 10:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200515222032.18838-7-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nQR9UOPe9CG83ZJTn7Wmom9HuwFjdi13o"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-18_03:2020-05-15,
 2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 04:50:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mst@redhat.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nQR9UOPe9CG83ZJTn7Wmom9HuwFjdi13o
Content-Type: multipart/mixed; boundary="JEf48FZ4m5jJbRC7y10A218kaJkk2Jgb6"

--JEf48FZ4m5jJbRC7y10A218kaJkk2Jgb6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/16/20 12:20 AM, Collin Walling wrote:
> As more features and facilities are added to the Read SCP Info (RSCPI)
> response, more space is required to store them. The space used to store=

> these new features intrudes on the space originally used to store CPU
> entries. This means as more features and facilities are added to the
> RSCPI response, less space can be used to store CPU entries.
>=20
> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
> the RSCPI command and determine if the SCCB is large enough to store a
> complete reponse. If it is not large enough, then the required length
> will be set in the SCCB header.
>=20
> The caller of the SCLP command is responsible for creating a
> large-enough SCCB to store a complete response. Proper checking should
> be in place, and the caller should execute the command once-more with
> the large-enough SCCB.
>=20
> This facility also enables an extended SCCB for the Read CPU Info
> (RCPUI) command.
>=20
> When this facility is enabled, the boundary violation response cannot
> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
>=20
> In order to tolerate kernels that do not yet have full support for this=

> feature, a "fixed" offset to the start of the CPU Entries within the
> Read SCP Info struct is set to allow for the original 248 max entries
> when this feature is disabled.
>=20
> Additionally, this is introduced as a CPU feature to protect the guest
> from migrating to a machine that does not support storing an extended
> SCCB. This could otherwise hinder the VM from being able to read all
> available CPU entries after migration (such as during re-ipl).
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/sclp.c                     | 21 ++++++++++++++++++++-
>  include/hw/s390x/sclp.h             |  1 +
>  target/s390x/cpu_features_def.inc.h |  1 +
>  target/s390x/gen-features.c         |  1 +
>  target/s390x/kvm.c                  |  4 ++++
>  5 files changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 755f5f3fab..bde4c5420e 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -56,6 +56,18 @@ static bool sccb_has_valid_boundary(uint64_t sccb_ad=
dr, uint32_t code,
>      uint64_t allowed_len =3D (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> =20
>      switch (code & SCLP_CMD_CODE_MASK) {
> +    case SCLP_CMDW_READ_SCP_INFO:
> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
> +    case SCLP_CMDW_READ_CPU_INFO:
> +        /*
> +         * An extended-length SCCB is only allowed for RSCPI and RSCPU=
 and is
> +         * allowed to exceed the 4k boundary. The respective commands =
will
> +         * set the length field to the required length if an insuffici=
ent
> +         * SCCB length is provided.
> +         */
> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
> +            return true;
> +        }
>      default:
>          if (current_len <=3D allowed_len) {
>              return true;
> @@ -72,6 +84,10 @@ static bool sccb_has_sufficient_len(SCCB *sccb, int =
num_cpus, int data_len)
> =20
>      if (be16_to_cpu(sccb->h.length) < required_len) {
>          sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCC=
B_LENGTH);
> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) &&
> +            sccb->h.control_mask[2] & SCLP_VARIABLE_LENGTH_RESPONSE) {=

> +            sccb->h.length =3D required_len;
> +        }
>          return false;
>      }
>      return true;
> @@ -101,7 +117,9 @@ static void prepare_cpu_entries(MachineState *ms, C=
PUEntry *entry, int *count)
>   */
>  static int get_read_scp_info_data_len(void)
>  {
> -    return offsetof(ReadInfo, entries);
> +    return s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
> +           offsetof(ReadInfo, entries) :
> +           SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET;
>  }
> =20
>  /* Provide information about the configuration, CPUs and storage */
> @@ -116,6 +134,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *s=
ccb)
>      CPUEntry *entries_start =3D (void *)sccb + data_len;
> =20
>      if (!sccb_has_sufficient_len(sccb, machine->possible_cpus->len, da=
ta_len)) {
> +        warn_report("insufficient sccb size to store full read scp inf=
o response");
>          return;
>      }
> =20
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index 822eff4396..ef2d63eae9 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -110,6 +110,7 @@ typedef struct CPUEntry {
>      uint8_t reserved1;
>  } QEMU_PACKED CPUEntry;
> =20
> +#define SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET     128
>  typedef struct ReadInfo {
>      SCCBHeader h;
>      uint16_t rnmax;
> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_fea=
tures_def.inc.h
> index 60db28351d..3548d65a69 100644
> --- a/target/s390x/cpu_features_def.inc.h
> +++ b/target/s390x/cpu_features_def.inc.h
> @@ -97,6 +97,7 @@ DEF_FEAT(GUARDED_STORAGE, "gs", STFL, 133, "Guarded-s=
torage facility")
>  DEF_FEAT(VECTOR_PACKED_DECIMAL, "vxpd", STFL, 134, "Vector packed deci=
mal facility")
>  DEF_FEAT(VECTOR_ENH, "vxeh", STFL, 135, "Vector enhancements facility"=
)
>  DEF_FEAT(MULTIPLE_EPOCH, "mepoch", STFL, 139, "Multiple-epoch facility=
")
> +DEF_FEAT(EXTENDED_LENGTH_SCCB, "els", STFL, 140, "Extended-length SCCB=
 facility")
>  DEF_FEAT(TEST_PENDING_EXT_INTERRUPTION, "tpei", STFL, 144, "Test-pendi=
ng-external-interruption facility")
>  DEF_FEAT(INSERT_REFERENCE_BITS_MULT, "irbm", STFL, 145, "Insert-refere=
nce-bits-multiple facility")
>  DEF_FEAT(MSA_EXT_8, "msa8-base", STFL, 146, "Message-security-assist-e=
xtension-8 facility (excluding subfunctions)")
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 8ddeebc544..6857f657fb 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -522,6 +522,7 @@ static uint16_t full_GEN12_GA1[] =3D {
>      S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
>      S390_FEAT_AP_FACILITIES_TEST,
>      S390_FEAT_AP,
> +    S390_FEAT_EXTENDED_LENGTH_SCCB,
>  };
> =20
>  static uint16_t full_GEN12_GA2[] =3D {
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 69881a0da0..380fb81822 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2456,6 +2456,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *m=
odel, Error **errp)
>          KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
>          set_bit(S390_FEAT_AP, model->features);
>      }
> +
> +    /* Extended-Length SCCB is handled entirely within QEMU */
> +    set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
> +

We need to fence this for secure guests as the SIDA is only 4k at the
moment.

Do we need to take extra steps for migration safety?
I guess this is only available with host-passthrough or -model?

>      /* strip of features that are not part of the maximum model */
>      bitmap_and(model->features, model->features, model->def->full_feat=
,
>                 S390_FEAT_MAX);
>=20



--JEf48FZ4m5jJbRC7y10A218kaJkk2Jgb6--

--nQR9UOPe9CG83ZJTn7Wmom9HuwFjdi13o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7CTXwACgkQ41TmuOI4
ufjomQ/8C7wBDjrX1B6BMZceAmf2JG2OYt1sXJksV4V7L0Rfy8jEWYj847ctXfSo
rzyqU8G2T/GE2rpsU+BaC/BiyhmOtzJHI9Dt6WTCz9z3QDqksNOFwUMi75VDoCSl
K9BdBSksEUHzZmUXX0n/dT1o6P52aZ7QBcD38gvDLD1lVdlC4+FVkhMlfvJtUWpS
PfB9czaSNyZuP4L3TK78QSVYMGHwtzQUr6pcfEVOvIi/P3zW7a7dGajybhgqcWk6
9vGW4ctOElAx6cBOjB2MAfSQYhtLniOTaMIf7U3j3BjSGnaKXf8DyPcaHgNH7NB0
exMTFiznzynKNpnvxjEs/sep3W9ybSuB6HQ3JMuG6sRpZWLtSmMkRY0T5MRBhWgR
kAwjmfyV939VC0tulJH1ugHMyjDU316XeqU/fjdg16ngnCW37DjjKlwdLAF8unhM
5bfOuQ9VNvevrOiLPs8BVK6M8qQbLcnL87MR2kO+N3pMn4ogTCSL0uq0uMV8t5I6
6Ek90iJuMVgkJhmv/FkSwPfppX5c7nputv1A1cfBSZMsC/6LA0U61Ps+zUtla5WT
QBHZUaiihLt6rhiEuOjqKTXZy1GLvNuMD7MehxGe8bsWdCYbWtuoUHKQadD6lW+2
36L2cqpWMgPnb+iTdHsO8dZpRuzutEV602JvNx1vy98bj60hECY=
=kqio
-----END PGP SIGNATURE-----

--nQR9UOPe9CG83ZJTn7Wmom9HuwFjdi13o--


