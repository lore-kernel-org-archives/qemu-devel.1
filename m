Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7512C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7952420789
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7952420789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvSg-0008MU-LQ
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jEvRa-0007Lg-Br
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jEvRY-0007XV-R9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:42:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21884
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jEvRY-0007Vs-Kh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:42:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JDWr9L051129
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:42:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yu98ug8kc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:42:39 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Thu, 19 Mar 2020 13:42:37 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 13:42:33 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02JDgWev39977350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 13:42:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A3F8AE051;
 Thu, 19 Mar 2020 13:42:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EADD6AE04D;
 Thu, 19 Mar 2020 13:42:31 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.104.230])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 13:42:31 +0000 (GMT)
Date: Thu, 19 Mar 2020 14:42:13 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when
 switching to protected mode
In-Reply-To: <20200227132402.67a38047.pasic@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
 <20200227132402.67a38047.pasic@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/9CKvFk4NF46rlgOJvg1hNtI"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
x-cbid: 20031913-0012-0000-0000-00000393DE0E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031913-0013-0000-0000-000021D0C3E3
Message-Id: <20200319144213.5b6b6ac0.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_04:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190058
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/9CKvFk4NF46rlgOJvg1hNtI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2020 13:24:02 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 26 Feb 2020 16:11:03 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
> > On 2/26/20 3:59 PM, David Hildenbrand wrote:
> > > On 26.02.20 13:20, Janosch Frank wrote:
> > >> Ballooning in protected VMs can only be done when the guest shares t=
he
> > >> pages it gives to the host. Hence, until we have a solution for this
> > >> in the guest kernel, we inhibit ballooning when switching into
> > >> protected mode and reverse that once we move out of it.
> > >=20
> > > I don't understand what you mean here, sorry. zapping a page will mean
> > > that a fresh one will be faulted in when accessed. And AFAIK, that me=
ans
> > > it will be encrypted again when needed.
> >=20
> > Yes, as soon as the host alters non-shared memory we'll run into
> > integrity issues.
> >=20
> >=20
> > I've been talking to Halil after I sent this out and it looks like we'll
> > rather try to automatically enable the IOMMU for all devices when
> > switching into protected mode. He said that if the IOMMU is set the
> > balloon code will do an early exit on feature negotiation.
> >=20
>=20
> I have a discussion starter RFC for you.
>=20
> --------------------------8<----------------------------------------------
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Wed, 26 Feb 2020 16:48:21 +0100
> Subject: [RFC PATCH 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
>=20
> The virtio specification tells that the device is to present
> VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> device "can only access certain memory addresses with said access
> specified and/or granted by the platform". This is the case for a
> protected VM, as the device can access only memory addresses that are in
> pages that are currently shared (only the guest can share/unsare its
> page).
>=20
> No VM however starts out as a protected VM, but some VMs may be
> converted to protected VMs if the guest decides so.
>=20
> Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
> the property iommu_on is a minor disaster. If the correctness of the
> paravirtualized virtio devices depends (and thus in a sense the
> correctness of the hypervisor), then the hypervisor should have the last
> word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or not.
>=20
> Let's manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatically
> for virtio-ccw devices, so that we set it before we start the protected
> configuration, and unset it when our VM is not protected.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> NOTES:
> * I wanted to have a discussion starter fast, there are multiple open
> questions.
>=20
> * Doing more than one system_resets() is hackish.  We
> should look into this.
>=20
> * The user interface implications of this patch are also an ugly can of
> worms. Needs to be discussed.
>=20
> * We should consider keeping the original value if !pv and restoring it
> on pv --> !pv, instead of forcing to unset when leaving pv, and actually
> not forcing unset when !pv.
>=20
> * It might make sense to do something like this in virtio core, but I
>   decided start the discussion with a ccw-only change.
>=20
> * Maybe we need a machine option that enables this sort of behavior,
> especially if we decide not to do the conserving/restoring.
>=20
> * Lightly tested.

ping

Any interest in this?

> ---
>  hw/s390x/s390-virtio-ccw.c |  4 ++--
>  hw/s390x/virtio-ccw.c      | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 0f4455d1df..996124f152 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -337,7 +337,7 @@ static void s390_machine_unprotect(S390CcwMachineStat=
e *ms)
>          ms->pv =3D false;
>      }
>      migrate_del_blocker(pv_mig_blocker);
> -    qemu_balloon_inhibit(false);
> +    subsystem_reset();
>  }
> =20
>  static int s390_machine_protect(S390CcwMachineState *ms)
> @@ -346,7 +346,6 @@ static int s390_machine_protect(S390CcwMachineState *=
ms)
>      CPUState *t;
>      int rc;
> =20
> -    qemu_balloon_inhibit(true);
>      if (!pv_mig_blocker) {
>          error_setg(&pv_mig_blocker,
>                     "protected VMs are currently not migrateable.");
> @@ -384,6 +383,7 @@ static int s390_machine_protect(S390CcwMachineState *=
ms)
>      if (rc) {
>          goto out_err;
>      }
> +    subsystem_reset();
>      return rc;
> =20
>  out_err:
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 13f57e7b67..48bb54f68e 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -869,12 +869,24 @@ static void virtio_ccw_notify(DeviceState *d, uint1=
6_t vector)
>      }
>  }
> =20
> +static inline void virtio_ccw_pv_enforce_features(VirtIODevice *vdev)
> +{
> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(qdev_get_machine());
> +
> +    if (ms->pv) {
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM=
);
> +    } else {
> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFO=
RM);
> +    }
> +}
> +
>  static void virtio_ccw_reset(DeviceState *d)
>  {
>      VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
>      VirtIODevice *vdev =3D virtio_bus_get_device(&dev->bus);
>      VirtIOCCWDeviceClass *vdc =3D VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> =20
> +    virtio_ccw_pv_enforce_features(vdev);
>      virtio_ccw_reset_virtio(dev, vdev);
>      if (vdc->parent_reset) {
>          vdc->parent_reset(d);
> @@ -1103,6 +1115,7 @@ static void virtio_ccw_pre_plugged(DeviceState *d, =
Error **errp)
>      if (dev->max_rev >=3D 1) {
>          virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
>      }
> +    virtio_ccw_pv_enforce_features(vdev);
>  }
> =20
>  /* This is called by virtio-bus just after the device is plugged. */
>=20
> base-commit: 8665f2475f5999d4c9f33598f1360f0b0797c489


--Sig_/9CKvFk4NF46rlgOJvg1hNtI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJec3bFAAoJEA0vhuyXGx0AIgoP/jX70xblviJsNQvx3PHKmHuj
PrKnS8GzcyfDdYfh5FqHOUPBAHOJKHyleO9Vqd0C1EVX9EnJNte+/5xrvLpAXaRK
iCYKamtoOSq4X7qKE87Wzd5oM1nFSMjDaUax20IdZs4FnU0Et5i7jCBS7zxf5ouk
igkRTgYFxw3UBjwVLfrkKE9V58j8qg9TQg+4KWc7h709JMVal4LudpPX45f5PtqB
Z4Fkrna3nHDVBGWn6fMpUZbygfhSM3mjhLT1jUl81frwoWChrLO7KG8CPI0bQ9P6
pANpxi/EipSEP7oU/SNDenkTQbEo5s17aIpQWYcuRmKwQGjKIi34Sx2uSVpqYo6o
R9L8sL/BkTG44dEkOPFnxY02YR7sairdwa8TWCoHcp/Peevy4ZOLnoZQGKAFR1rv
n3iMc+4oPWcpvWZZ2BDUHYN2NnuAQgfhHK9yV0zS5u6T9cf43vT7ovjV9RHioGUP
2ERF4OLv4dw3kCLoiMlGDGkNko65vOAWlpfhY7ksIb6spBEc6rySD8/PWDgowdvd
sdzm9I/XjhzQIdv/IyoGpXQx/Q5FUrzvTBRcxis2AHliGgLm952oZFedI2XBw6e5
CPJOj0iODzlB5kBoDAts6dYIFL4DKxGFdLZkmaw1PGGS/KGpY76qOaSVlSPB/h7d
VR5/LCdccodgetyX7OMO
=T+8b
-----END PGP SIGNATURE-----

--Sig_/9CKvFk4NF46rlgOJvg1hNtI--


