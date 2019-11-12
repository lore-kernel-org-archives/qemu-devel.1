Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BAEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC2B206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC2B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTSI-0003ba-8I
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUTRD-00034B-Sv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUTRB-0001mx-VL
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:30:19 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:49831)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUTRB-0001m5-Lz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:30:17 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MLi0U-1iCwaB3bma-00HgiT; Tue, 12 Nov 2019 11:30:04 +0100
Subject: Re: [PULL v2 01/13] linux-user: Support for NETLINK socket options
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191106130456.6176-1-laurent@vivier.eu>
 <20191106130456.6176-2-laurent@vivier.eu>
 <CAFEAcA-fTQzYjDtHRzghwA6EAREN=m=JixWJzOMkBc7ZPDmp_g@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5ba55431-a71f-3f42-0a6f-fd4d2c9a1920@vivier.eu>
Date: Tue, 12 Nov 2019 11:30:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-fTQzYjDtHRzghwA6EAREN=m=JixWJzOMkBc7ZPDmp_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mSJFn/Z4GL7H3mFQT9ql18i1hUpTXJzHX+6KUun+jsq8iCvWTT5
 onJW0NMumrv4JQioZyjFPR87nErLG/TLSp3+Up/x/65xGaryBWp+yfspPEu2+YQsT9kr6BN
 YfjAsWj4+1z4WkswS03abvrFwwdDvxfcaIGRu8BxevwNwljisEsY5k9QaNiGkWP0cx4+Fsw
 xHtV/zu8nedjfk/EVjHIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aYMIHX1rtkU=:YKX0t4VXU2Oiw9Dm8T2iYV
 h9Jkb6F/azFbdfmAUzjVR0ayzGKrnrScFrWV8Igr4SiaU0s7KG84myUhYxcJDbj6cDi+87z7b
 nttb1P1JHhJDtTDV51O8dQEojotm3lUwYhMAfZLZVkNpiXpoMhNw7EHwhZdyGOkvSd3c47GrJ
 bbxTBRF3GikG+NePnkKMlvgEhghQFZBNwNSByYCMjS4X2+JamvaBv27xui5XyJL8VIhEHhxxA
 0HXwCXp1TTvTzXvdgFMAp7OJzis5XhgOVkq6QmaVliG9d3KpxM1Usck0pE2I2+ajsCiP3v9TM
 QFFMz99ExH2Iw8MAQnIvIwybqF7TeYcJ+WlQzOpOZBrM+zYoJLtx/O2PQVPGIVKvXVo2tuw6V
 KET8iwZ81l3lZQNdr2xCgMWaKlJ/CJtdBzJsQc+quNY/olOZwwC59LF1xcetYvHv1Bd+5XXNB
 KB4Z+QCzwyx1zl1Oml8KQ8ovHgq9oXHkfJzD/6vcg+5hxRGbdmfcIX28QtBmIlsM5PgCPu4Bc
 5WK12cXxDBZ8nOJWiTPWDUdL6q1jlJAn+5gttkSHdWNGOQAkcz365ycZpmQOu3kV7dxfwQZif
 gswd4/scRJiI+PaDGI5l6KKxjMiVNzfBIqZrVE5n3crAmkW1M9NvYhEqugolOqVvmIQSOJ2xH
 n1WygpUKv+I19Wgn//qteol0MXL7jwxWjb25KoVHqx7YnV3GAoS7h+x2SmUhFX81acXGI1+yl
 1q/rgMC89rXbA6vdms9gcvWuCP/vDkR/0zGd9kHvwM5ZRFJmQepc90AlggF0h8tBmPEiyZlmi
 eWp0Hj9TSL7n0u91aTr4TkMw7v3fFAtUl5Vkfo4o5YRrGqOMsko7bFioDQUPzbkVUZ4S8YCDY
 5kwvuggAuqFwFclaNYsHo1lVnmN3ucGQfSyMHPn28=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Josh Kunz <jkz@google.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/11/2019 à 11:11, Peter Maydell a écrit :
> On Wed, 6 Nov 2019 at 13:07, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> From: Josh Kunz <jkz@google.com>
>>
>> This change includes support for all AF_NETLINK socket options up to about
>> kernel version 5.4 (5.4 is not formally released at the time of writing).
>> Socket options that were introduced in kernel versions before the oldest
>> currently stable kernel version are guarded by kernel version macros.
>>
>> This change has been built under gcc 8.3, and clang 9.0, and it passes
>> `make check`. The netlink options have been tested by emulating some
>> non-trival software that uses NETLINK socket options, but they have
>> not been exaustively verified.
> 
> Hi; Coverity reports a missing-break-in-switch error for
> this commit (CID 1407221):
> 
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index f6751eecb78c..247883292ce5 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -2248,6 +2248,39 @@ set_timeout:
>>              return -TARGET_EFAULT;
>>         ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val, sizeof(val)));
>>          break;
>> +#ifdef SOL_NETLINK
>> +    case SOL_NETLINK:
>> +        switch (optname) {
>> +        case NETLINK_PKTINFO:
>> +        case NETLINK_ADD_MEMBERSHIP:
>> +        case NETLINK_DROP_MEMBERSHIP:
>> +        case NETLINK_BROADCAST_ERROR:
>> +        case NETLINK_NO_ENOBUFS:
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
>> +        case NETLINK_LISTEN_ALL_NSID:
>> +        case NETLINK_CAP_ACK:
>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0)
>> +        case NETLINK_EXT_ACK:
>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 20, 0)
>> +        case NETLINK_GET_STRICT_CHK:
>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
>> +            break;
>> +        default:
>> +            goto unimplemented;
>> +        }
>> +        val = 0;
>> +        if (optlen < sizeof(uint32_t)) {
>> +            return -TARGET_EINVAL;
>> +        }
>> +        if (get_user_u32(val, optval_addr)) {
>> +            return -TARGET_EFAULT;
>> +        }
>> +        ret = get_errno(setsockopt(sockfd, SOL_NETLINK, optname, &val,
>> +                                   sizeof(val)));
>> +        break;
>> +#endif /* SOL_NETLINK */
>>      default:
>>      unimplemented:
>>          gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
>> @@ -2532,6 +2565,74 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>>              break;
>>          }
>>          break;
>> +#ifdef SOL_NETLINK
>> +    case SOL_NETLINK:
>> +        switch (optname) {
>> +        case NETLINK_PKTINFO:
>> +        case NETLINK_BROADCAST_ERROR:
>> +        case NETLINK_NO_ENOBUFS:
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
>> +        case NETLINK_LISTEN_ALL_NSID:
>> +        case NETLINK_CAP_ACK:
>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0)
>> +        case NETLINK_EXT_ACK:
>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 20, 0)
>> +        case NETLINK_GET_STRICT_CHK:
>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 12, 0) */
>> +            if (get_user_u32(len, optlen)) {
>> +                return -TARGET_EFAULT;
>> +            }
>> +            if (len != sizeof(val)) {
>> +                return -TARGET_EINVAL;
>> +            }
>> +            lv = len;
>> +            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>> +            if (put_user_u32(lv, optlen)
>> +                || put_user_u32(val, optval_addr)) {
>> +                return -TARGET_EFAULT;
>> +            }
>> +            break;
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0)
>> +        case NETLINK_LIST_MEMBERSHIPS:
>> +        {
>> +            uint32_t *results;
>> +            int i;
>> +            if (get_user_u32(len, optlen)) {
>> +                return -TARGET_EFAULT;
>> +            }
>> +            if (len < 0) {
>> +                return -TARGET_EINVAL;
>> +            }
>> +            results = lock_user(VERIFY_WRITE, optval_addr, len, 1);
>> +            if (!results) {
>> +                return -TARGET_EFAULT;
>> +            }
>> +            lv = len;
>> +            ret = get_errno(getsockopt(sockfd, level, optname, results, &lv));
>> +            if (ret < 0) {
>> +                unlock_user(results, optval_addr, 0);
>> +                return ret;
>> +            }
>> +            /* swap host endianess to target endianess. */
>> +            for (i = 0; i < (len / sizeof(uint32_t)); i++) {
>> +                results[i] = tswap32(results[i]);
>> +            }
>> +            if (put_user_u32(lv, optlen)) {
>> +                return -TARGET_EFAULT;
>> +            }
>> +            unlock_user(results, optval_addr, 0);
>> +            break;
>> +        }
>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
>> +        default:
>> +            goto unimplemented;
>> +        }
>> +#endif /* SOL_NETLINK */
> 
> Here at the end of the 'case SOL_NETLINK' we will just
> fall straight through into 'default:'. Missing 'break' ?

Yes, missing 'break'.

I'm going to send a patch to fix that.

Thanks,
Laurent

