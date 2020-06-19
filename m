Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD18C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1423206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1423206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmDIr-0000wf-5P
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 05:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jmDDt-0000Ke-4Y; Fri, 19 Jun 2020 05:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jmDDq-0004Js-IU; Fri, 19 Jun 2020 05:22:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J92qd4101142; Fri, 19 Jun 2020 05:22:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rekdjfws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 05:22:04 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05J943BC108665;
 Fri, 19 Jun 2020 05:22:03 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rekdjfvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 05:22:03 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J9L7Em024198;
 Fri, 19 Jun 2020 09:22:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma02fra.de.ibm.com with ESMTP id 31r0dvrvrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 09:22:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05J9LwPK62783706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 09:21:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 137A3A405F;
 Fri, 19 Jun 2020 09:21:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6239EA405C;
 Fri, 19 Jun 2020 09:21:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.7.233])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2020 09:21:57 +0000 (GMT)
Subject: Re: [PATCH v3 8/8] s390: guest support for diagnose 0x318
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-9-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e865a199-5e5e-1990-55a5-dec238d119f5@linux.ibm.com>
Date: Fri, 19 Jun 2020 11:21:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618222258.23287-9-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7y1b8JCaZxSqRgzs1qMyUsmgOtMSbEWcm"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_05:2020-06-18,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 cotscore=-2147483648 mlxlogscore=999 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190067
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 04:18:48
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7y1b8JCaZxSqRgzs1qMyUsmgOtMSbEWcm
Content-Type: multipart/mixed; boundary="zikmqNQc6OBYfXQct5Tn4gPFokww78mNt"

--zikmqNQc6OBYfXQct5Tn4gPFokww78mNt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/19/20 12:22 AM, Collin Walling wrote:
> DIAGNOSE 0x318 (diag318) is an s390 instruction that allows the storage=

> of diagnostic information that is collected by the firmware in the case=

> of hardware/firmware service events.
>=20
> QEMU handles the instruction by storing the info in the CPU state. A
> subsequent register sync will communicate the data to the hypervisor.
>=20
> QEMU handles the migration via a VM State Description.
>=20
> This feature depends on the Extended-Length SCCB (els) feature. If
> els is not present, then a warning will be printed and the SCLP bit
> that allows the Linux kernel to execute the instruction will not be
> set.
>=20
> Availability of this instruction is determined by byte 134 (aka fac134)=

> bit 0 of the SCLP Read Info block. This coincidentally expands into the=

> space used for CPU entries, which means VMs running with the diag318
> capability may not be able to read information regarding all CPUs
> unless the guest kernel supports an extended-length SCCB.
>=20
> This feature is not supported in protected virtualization mode.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  hw/s390x/sclp.c                     |  5 +++++
>  include/hw/s390x/sclp.h             |  3 +++
>  target/s390x/cpu.h                  |  3 ++-
>  target/s390x/cpu_features.h         |  1 +
>  target/s390x/cpu_features_def.inc.h |  3 +++
>  target/s390x/cpu_models.c           |  1 +
>  target/s390x/gen-features.c         |  1 +
>  target/s390x/kvm.c                  | 31 +++++++++++++++++++++++++++++=

>  target/s390x/machine.c              | 17 ++++++++++++++++
>  9 files changed, 64 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index f7c49e339e..78dbfbe427 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -152,6 +152,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *=
sccb)
>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>                           read_info->conf_char_ext);
> =20
> +    if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
> +        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
> +                            &read_info->fac134);
> +    }
> +
>      read_info->facilities =3D cpu_to_be64(SCLP_HAS_CPU_INFO |
>                                          SCLP_HAS_IOA_RECONFIG);
> =20
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index ef2d63eae9..ccb9f0a676 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -133,6 +133,9 @@ typedef struct ReadInfo {
>      uint16_t highest_cpu;
>      uint8_t  _reserved5[124 - 122];     /* 122-123 */
>      uint32_t hmfai;
> +    uint8_t  _reserved7[134 - 128];     /* 128-133 */
> +    uint8_t  fac134;
> +    uint8_t  _reserved8[144 - 135];     /* 135-143 */
>      struct CPUEntry entries[];
>  } QEMU_PACKED ReadInfo;
> =20
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 035427521c..52765961cf 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -112,6 +112,8 @@ struct CPUS390XState {
>      uint16_t external_call_addr;
>      DECLARE_BITMAP(emergency_signals, S390_MAX_CPUS);
> =20
> +    uint64_t diag318_info;
> +
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
> =20
> @@ -136,7 +138,6 @@ struct CPUS390XState {
> =20
>      /* currently processed sigp order */
>      uint8_t sigp_order;
> -

Whitespace damage

>  };
> =20
>  static inline uint64_t *get_freg(CPUS390XState *cs, int nr)
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index da695a8346..f74f7fc3a1 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -23,6 +23,7 @@ typedef enum {
>      S390_FEAT_TYPE_STFL,
>      S390_FEAT_TYPE_SCLP_CONF_CHAR,
>      S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
> +    S390_FEAT_TYPE_SCLP_FAC134,
>      S390_FEAT_TYPE_SCLP_CPU,
>      S390_FEAT_TYPE_MISC,
>      S390_FEAT_TYPE_PLO,
> diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_fea=
tures_def.inc.h
> index 1c04cc18f4..f82b4b5ec1 100644
> --- a/target/s390x/cpu_features_def.inc.h
> +++ b/target/s390x/cpu_features_def.inc.h
> @@ -122,6 +122,9 @@ DEF_FEAT(SIE_CMMA, "cmma", SCLP_CONF_CHAR_EXT, 1, "=
SIE: Collaborative-memory-man
>  DEF_FEAT(SIE_PFMFI, "pfmfi", SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpr=
etation facility")
>  DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-b=
roadcast-suppression facility")
> =20
> +/* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers rel=
ative to byte-134) */
> +DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name an=
d version codes")
> +
>  /* Features exposed via SCLP CPU info. */
>  DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Vi=
rtual SIE)")
>  DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 2fa609bffe..034673be54 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -827,6 +827,7 @@ static void check_consistency(const S390CPUModel *m=
odel)
>          { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
>          { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
>          { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
> +        { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
>      };
>      int i;
> =20
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 6857f657fb..a1f0a6f3c6 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -523,6 +523,7 @@ static uint16_t full_GEN12_GA1[] =3D {
>      S390_FEAT_AP_FACILITIES_TEST,
>      S390_FEAT_AP,
>      S390_FEAT_EXTENDED_LENGTH_SCCB,
> +    S390_FEAT_DIAG_318,
>  };
> =20
>  static uint16_t full_GEN12_GA2[] =3D {
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index a2d5ad78f6..b79feeba9f 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -105,6 +105,7 @@
> =20
>  #define DIAG_TIMEREVENT                 0x288
>  #define DIAG_IPL                        0x308
> +#define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
>  #define DIAG_KVM_HYPERCALL              0x500
>  #define DIAG_KVM_BREAKPOINT             0x501
> =20
> @@ -602,6 +603,11 @@ int kvm_arch_put_registers(CPUState *cs, int level=
)
>          cs->kvm_run->kvm_dirty_regs |=3D KVM_SYNC_ETOKEN;
>      }
> =20
> +    if (can_sync_regs(cs, KVM_SYNC_DIAG318)) {
> +        cs->kvm_run->s.regs.diag318 =3D env->diag318_info;
> +        cs->kvm_run->kvm_dirty_regs |=3D KVM_SYNC_DIAG318;
> +    }
> +
>      /* Finally the prefix */
>      if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
>          cs->kvm_run->s.regs.prefix =3D env->psa;
> @@ -741,6 +747,10 @@ int kvm_arch_get_registers(CPUState *cs)
>          }
>      }
> =20
> +    if (can_sync_regs(cs, KVM_SYNC_DIAG318)) {
> +        env->diag318_info =3D cs->kvm_run->s.regs.diag318;
> +    }
> +
>      return 0;
>  }
> =20
> @@ -1601,6 +1611,19 @@ static int handle_sw_breakpoint(S390CPU *cpu, st=
ruct kvm_run *run)
>      return -ENOENT;
>  }
> =20
> +static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
> +{
> +    uint64_t reg =3D (run->s390_sieic.ipa & 0x00f0) >> 4;
> +    uint64_t diag318_info =3D run->s.regs.gprs[reg];
> +
> +    cpu->env.diag318_info =3D diag318_info;
> +
> +    if (can_sync_regs(CPU(cpu), KVM_SYNC_DIAG318)) {
> +        run->s.regs.diag318 =3D diag318_info;
> +        run->kvm_dirty_regs |=3D KVM_SYNC_DIAG318;
> +    }
> +}
> +
>  #define DIAG_KVM_CODE_MASK 0x000000000000ffff
> =20
>  static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb=
)
> @@ -1620,6 +1643,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_r=
un *run, uint32_t ipb)
>      case DIAG_IPL:
>          kvm_handle_diag_308(cpu, run);
>          break;
> +    case DIAG_SET_CONTROL_PROGRAM_CODES:
> +        handle_diag_318(cpu, run);
> +        break;
>      case DIAG_KVM_HYPERCALL:
>          r =3D handle_hypercall(cpu, run);
>          break;
> @@ -2464,6 +2490,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *m=
odel, Error **errp)
>       */
>      set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
> =20
> +    /* DIAGNOSE 0x318 is not supported under protected virtualization =
*/
> +    if (!s390_is_pv() && kvm_check_extension(kvm_state, KVM_CAP_S390_D=
IAG318)) {
> +        set_bit(S390_FEAT_DIAG_318, model->features);
> +    }
> +
>      /* strip of features that are not part of the maximum model */
>      bitmap_and(model->features, model->features, model->def->full_feat=
,
>                 S390_FEAT_MAX);
> diff --git a/target/s390x/machine.c b/target/s390x/machine.c
> index 549bb6c280..5b4e82f1ab 100644
> --- a/target/s390x/machine.c
> +++ b/target/s390x/machine.c
> @@ -234,6 +234,22 @@ const VMStateDescription vmstate_etoken =3D {
>      }
>  };
> =20
> +static bool diag318_needed(void *opaque)
> +{
> +    return s390_has_feat(S390_FEAT_DIAG_318);
> +}
> +
> +const VMStateDescription vmstate_diag318 =3D {
> +    .name =3D "cpu/diag318",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D diag318_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(env.diag318_info, S390CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_s390_cpu =3D {
>      .name =3D "cpu",
>      .post_load =3D cpu_post_load,
> @@ -270,6 +286,7 @@ const VMStateDescription vmstate_s390_cpu =3D {
>          &vmstate_gscb,
>          &vmstate_bpbc,
>          &vmstate_etoken,
> +        &vmstate_diag318,
>          NULL
>      },
>  };
>=20



--zikmqNQc6OBYfXQct5Tn4gPFokww78mNt--

--7y1b8JCaZxSqRgzs1qMyUsmgOtMSbEWcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7sg7QACgkQ41TmuOI4
ufhzlhAAvfbM/krXrMug6EtobbuMzYVMvefDpSsWU8ApcvoL4ILpTuVAlrNE+sK9
wljzD1ZnI6R2ws0g2/SEf/cfdrlKNciZCFBJG9MkUTk0W8VGBUZXOO1LiuMSmv/6
yzh/fSh0xXGtGlCM0+cLh0XPvvkXnoCWudi6aFYdQK4I/Y52yuHrpEl0rXFdzxhT
94fe5sjrfV8PM9fbfzMXM5AgKvrN5p0nur8sLiUJr8VmB8xOoP+Fj8JqL6Ks1Ojv
JbKWoeuz9kMI+DaR8cY9k3srA/LMNU6T7FCBki5o2DuwXWPHZOatYqcpaFZLECOP
5StkgsPFs9h1R061K2J6q4q1OpENtEkYMA2HLoCXPqqdzEePPeHcT4Q6qU/akc/L
ReTgVTnYOte1xD//CeweJ3/ji4m5okCcggWNBOvxKasLSJb6nSJ6rVFRkBt4JDwW
ckW0dkRt4KHPZFdtyki9uDHSjMPyeLAOyQtLhw9bcXxXINQ1mHA/4/lUpAqtNrgP
euOhSDQZefZyoZ24pwZsB0ffCOOnXJZ9EyBtp0yG+JSFPpy+UGXxS1Svm02kBNA1
WCs44/8bftmAwcxCAMoayLuFQsrKpoIV0U5MXPRPQAsmO8/9nfMuSalPsb99ec3C
VO3Qx6lMGMtwW1SWp31M5Cv9H7QWTm7WpLeu+gpaYnRjToMYpZ4=
=WLJP
-----END PGP SIGNATURE-----

--7y1b8JCaZxSqRgzs1qMyUsmgOtMSbEWcm--


