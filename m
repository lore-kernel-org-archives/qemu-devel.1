Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A4C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 07:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2E121849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 07:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2E121849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNHs-0008D4-V9
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 03:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32861)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <borntraeger@de.ibm.com>) id 1hoNHf-0007o8-ER
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1hoNHd-00008I-J5
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:26:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22196
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1hoNHd-00007u-Dn
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 03:26:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6J7P02s102563
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 03:26:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tu8ggj5jy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 03:26:23 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Fri, 19 Jul 2019 08:26:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 19 Jul 2019 08:26:17 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6J7QGfv57081974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2019 07:26:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5499911C054;
 Fri, 19 Jul 2019 07:26:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC76411C050;
 Fri, 19 Jul 2019 07:26:15 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.115])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jul 2019 07:26:15 +0000 (GMT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190718130641.15294-1-laurent@vivier.eu>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date: Fri, 19 Jul 2019 09:26:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718130641.15294-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19071907-0016-0000-0000-00000294443D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071907-0017-0000-0000-000032F223CC
Message-Id: <2fa2fa41-859c-f18d-d71a-d85e38372698@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-19_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907190083
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x6J7P02s102563
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v6] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.07.19 15:06, Laurent Vivier wrote:
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> The SIOCGSTAMP symbol was previously defined in the
> asm-generic/sockios.h header file. QEMU sees that header
> indirectly via sys/socket.h
>=20
> In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
> the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
> Instead it provides only SIOCGSTAMP_OLD, which only uses a
> 32-bit time_t on 32-bit architectures.
>=20
> The linux/sockios.h header then defines SIOCGSTAMP using
> either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
> SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
> on 32-bit architectures
>=20
> To cope with this we must now convert the old and new type from
> the target to the host one.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I can confirm that this fixes the compile errors with newer kernel header=
s
and I think we should have this for 4.1.

> ---
>=20
> Notes:
>     v6: [lv] fix IOCTLEntry entries (host_cmd and name)
>     v5: [lv] define special _OLD values for sh
>         define special case for SPARC64
>         define ioctl helpers
>         define target__kernel_sock_timeval and target__kernel_timespec =
and
>         converters to the host type
>         always use SIOCGSTAMP and SIOCGSTAMPNS on the host
>    =20
>     v4: [lv] timeval64 and timespec64 are {=C2=A0long long , long }
>    =20
>     v3: [lv] redefine TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMPNS_NEW,
>         timeval64 and timespec64 to use 0x89 type and abi_llong[2]
>    =20
>     v2: [dpb] implement _NEW and _OLD variants
>=20
>  linux-user/ioctls.h        |  21 +++++-
>  linux-user/syscall.c       | 140 +++++++++++++++++++++++++++++--------
>  linux-user/syscall_defs.h  |  30 +++++++-
>  linux-user/syscall_types.h |   6 --
>  4 files changed, 159 insertions(+), 38 deletions(-)
>=20
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 5e84dc7c3a77..3281c97ca263 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -222,8 +222,25 @@
>    IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq=
)))
>    IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
>    IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
> -  IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
> -  IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
> +
> +  /*
> +   * We can't use IOCTL_SPECIAL() because it will set
> +   * host_cmd to XXX_OLD and XXX_NEW and these macros
> +   * are not defined with kernel prior to 5.2.
> +   * We must set host_cmd to the same value as in target_cmd
> +   * otherwise the consistency check in syscall_init()
> +   * will trigger an error.
> +   * host_cmd is ignored by the do_ioctl_XXX() helpers.
> +   * FIXME: create a macro to define this kind of entry
> +   */
> +  { TARGET_SIOCGSTAMP_OLD, TARGET_SIOCGSTAMP_OLD,
> +    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP },
> +  { TARGET_SIOCGSTAMPNS_OLD, TARGET_SIOCGSTAMPNS_OLD,
> +    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS },
> +  { TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMP_NEW,
> +    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP },
> +  { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW,
> +    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS },
> =20
>    IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
>    IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 39a37496fed5..8367cb138dfe 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -37,6 +37,7 @@
>  #include <sched.h>
>  #include <sys/timex.h>
>  #include <sys/socket.h>
> +#include <linux/sockios.h>
>  #include <sys/un.h>
>  #include <sys/uio.h>
>  #include <poll.h>
> @@ -1126,8 +1127,9 @@ static inline abi_long copy_from_user_timeval(str=
uct timeval *tv,
>  {
>      struct target_timeval *target_tv;
> =20
> -    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1))
> +    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) =
{
>          return -TARGET_EFAULT;
> +    }
> =20
>      __get_user(tv->tv_sec, &target_tv->tv_sec);
>      __get_user(tv->tv_usec, &target_tv->tv_usec);
> @@ -1142,8 +1144,26 @@ static inline abi_long copy_to_user_timeval(abi_=
ulong target_tv_addr,
>  {
>      struct target_timeval *target_tv;
> =20
> -    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0))
> +    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0))=
 {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    __put_user(tv->tv_sec, &target_tv->tv_sec);
> +    __put_user(tv->tv_usec, &target_tv->tv_usec);
> +
> +    unlock_user_struct(target_tv, target_tv_addr, 1);
> +
> +    return 0;
> +}
> +
> +static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr=
,
> +                                             const struct timeval *tv)
> +{
> +    struct target__kernel_sock_timeval *target_tv;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0))=
 {
>          return -TARGET_EFAULT;
> +    }
> =20
>      __put_user(tv->tv_sec, &target_tv->tv_sec);
>      __put_user(tv->tv_usec, &target_tv->tv_usec);
> @@ -1153,6 +1173,48 @@ static inline abi_long copy_to_user_timeval(abi_=
ulong target_tv_addr,
>      return 0;
>  }
> =20
> +static inline abi_long target_to_host_timespec(struct timespec *host_t=
s,
> +                                               abi_ulong target_addr)
> +{
> +    struct target_timespec *target_ts;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
> +    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_addr, 0);
> +    return 0;
> +}
> +
> +static inline abi_long host_to_target_timespec(abi_ulong target_addr,
> +                                               struct timespec *host_t=
s)
> +{
> +    struct target_timespec *target_ts;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_ts->tv_sec, &target_ts->tv_sec);
> +    __put_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_addr, 1);
> +    return 0;
> +}
> +
> +static inline abi_long host_to_target_timespec64(abi_ulong target_addr=
,
> +                                                 struct timespec *host=
_ts)
> +{
> +    struct target__kernel_timespec *target_ts;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_ts->tv_sec, &target_ts->tv_sec);
> +    __put_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_addr, 1);
> +    return 0;
> +}
> +
>  static inline abi_long copy_from_user_timezone(struct timezone *tz,
>                                                 abi_ulong target_tz_add=
r)
>  {
> @@ -4899,6 +4961,54 @@ static abi_long do_ioctl_kdsigaccept(const IOCTL=
Entry *ie, uint8_t *buf_temp,
>      return get_errno(safe_ioctl(fd, ie->host_cmd, sig));
>  }
> =20
> +static abi_long do_ioctl_SIOCGSTAMP(const IOCTLEntry *ie, uint8_t *buf=
_temp,
> +                                    int fd, int cmd, abi_long arg)
> +{
> +    struct timeval tv;
> +    abi_long ret;
> +
> +    ret =3D get_errno(safe_ioctl(fd, SIOCGSTAMP, &tv));
> +    if (is_error(ret)) {
> +        return ret;
> +    }
> +
> +    if (cmd =3D=3D (int)TARGET_SIOCGSTAMP_OLD) {
> +        if (copy_to_user_timeval(arg, &tv)) {
> +            return -TARGET_EFAULT;
> +        }
> +    } else {
> +        if (copy_to_user_timeval64(arg, &tv)) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static abi_long do_ioctl_SIOCGSTAMPNS(const IOCTLEntry *ie, uint8_t *b=
uf_temp,
> +                                      int fd, int cmd, abi_long arg)
> +{
> +    struct timespec ts;
> +    abi_long ret;
> +
> +    ret =3D get_errno(safe_ioctl(fd, SIOCGSTAMPNS, &ts));
> +    if (is_error(ret)) {
> +        return ret;
> +    }
> +
> +    if (cmd =3D=3D (int)TARGET_SIOCGSTAMPNS_OLD) {
> +        if (host_to_target_timespec(arg, &ts)) {
> +            return -TARGET_EFAULT;
> +        }
> +    } else{
> +        if (host_to_target_timespec64(arg, &ts)) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>  #ifdef TIOCGPTPEER
>  static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *bu=
f_temp,
>                                       int fd, int cmd, abi_long arg)
> @@ -6271,32 +6381,6 @@ static inline abi_long target_ftruncate64(void *=
cpu_env, abi_long arg1,
>  }
>  #endif
> =20
> -static inline abi_long target_to_host_timespec(struct timespec *host_t=
s,
> -                                               abi_ulong target_addr)
> -{
> -    struct target_timespec *target_ts;
> -
> -    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1))
> -        return -TARGET_EFAULT;
> -    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
> -    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> -    unlock_user_struct(target_ts, target_addr, 0);
> -    return 0;
> -}
> -
> -static inline abi_long host_to_target_timespec(abi_ulong target_addr,
> -                                               struct timespec *host_t=
s)
> -{
> -    struct target_timespec *target_ts;
> -
> -    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_addr, 0))
> -        return -TARGET_EFAULT;
> -    __put_user(host_ts->tv_sec, &target_ts->tv_sec);
> -    __put_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> -    unlock_user_struct(target_ts, target_addr, 1);
> -    return 0;
> -}
> -
>  static inline abi_long target_to_host_itimerspec(struct itimerspec *ho=
st_itspec,
>                                                   abi_ulong target_addr=
)
>  {
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index fffa89f2564b..06622703008a 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -209,16 +209,34 @@ struct target_linger {
>      abi_int l_linger;       /* How long to linger for       */
>  };
> =20
> +#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
> +struct target_timeval {
> +    abi_long tv_sec;
> +    abi_int tv_usec;
> +};
> +#define target__kernel_sock_timeval target_timeval
> +#else
>  struct target_timeval {
>      abi_long tv_sec;
>      abi_long tv_usec;
>  };
> =20
> +struct target__kernel_sock_timeval {
> +    abi_llong tv_sec;
> +    abi_llong tv_usec;
> +};
> +#endif
> +
>  struct target_timespec {
>      abi_long tv_sec;
>      abi_long tv_nsec;
>  };
> =20
> +struct target__kernel_timespec {
> +    abi_llong tv_sec;
> +    abi_llong tv_nsec;
> +};
> +
>  struct target_timezone {
>      abi_int tz_minuteswest;
>      abi_int tz_dsttime;
> @@ -749,8 +767,16 @@ struct target_pollfd {
>  #define TARGET_SIOCGPGRP       0x8904
>  #endif
> =20
> -#define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) =
*/
> -#define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec)=
 */
> +#if defined(TARGET_SH4)
> +#define TARGET_SIOCGSTAMP_OLD   TARGET_IOR('s', 100, struct target_tim=
eval)
> +#define TARGET_SIOCGSTAMPNS_OLD TARGET_IOR('s', 101, struct target_tim=
espec)
> +#else
> +#define TARGET_SIOCGSTAMP_OLD   0x8906
> +#define TARGET_SIOCGSTAMPNS_OLD 0x8907
> +#endif
> +
> +#define TARGET_SIOCGSTAMP_NEW   TARGET_IOR(0x89, 0x06, abi_llong[2])
> +#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOR(0x89, 0x07, abi_llong[2])
> =20
>  /* Networking ioctls */
>  #define TARGET_SIOCADDRT       0x890B          /* add routing table en=
try */
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index b98a23b0f1b0..4e3698382629 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -14,12 +14,6 @@ STRUCT(serial_icounter_struct,
>  STRUCT(sockaddr,
>         TYPE_SHORT, MK_ARRAY(TYPE_CHAR, 14))
> =20
> -STRUCT(timeval,
> -       MK_ARRAY(TYPE_LONG, 2))
> -
> -STRUCT(timespec,
> -       MK_ARRAY(TYPE_LONG, 2))
> -
>  STRUCT(rtentry,
>         TYPE_ULONG, MK_STRUCT(STRUCT_sockaddr), MK_STRUCT(STRUCT_sockad=
dr), MK_STRUCT(STRUCT_sockaddr),
>         TYPE_SHORT, TYPE_SHORT, TYPE_ULONG, TYPE_PTRVOID, TYPE_SHORT, T=
YPE_PTRVOID,
>=20


