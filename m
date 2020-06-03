Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ABDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA93820678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA93820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgS8I-0005uo-1x
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgS7g-0005Nd-J5
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:03:56 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgS7f-0006sS-5P
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:03:56 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M1INQ-1ji74n0YAM-002lYK; Wed, 03 Jun 2020 14:03:43 +0200
Subject: Re: [PATCH v5] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: Chen Gang <chengang@emindsoft.com.cn>, riku.voipio@iki.fi
References: <20200603010809.32139-1-chengang@emindsoft.com.cn>
 <02add5c5-e1ad-050e-229e-c5a7d2afdf2b@vivier.eu>
 <ce96cb20-80e7-e561-1eee-fcdca38d376f@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1e1a2b6d-39ea-04aa-80ea-bcccdfd84a49@vivier.eu>
Date: Wed, 3 Jun 2020 14:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ce96cb20-80e7-e561-1eee-fcdca38d376f@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SgpMFbxKqoCHzhWqnMllSnXQrqbIEBZfaeQ1OUwOlB87w7LyXmc
 hS/in0lyVT7geT2ul8yHnM6qsi65qQ9/34pnfOnt6Tyr072iOnOs6f5XnurEtTAT1yJFNuK
 UEdRA12WMS2g+bUbsMSeKb+hiqv1QqCfeJmEG5BSnQ6QSr1W4K2wQisIFznHZixOdgp2lpy
 s7yMGiedx5ZHsUw78me5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S/iechIrEoc=:/xjGnTw4Po80D5hqQ8YQBQ
 y8qlVQ0tJyvid2B414NkpXqhUIJUKvAoRofR+cCcVGPdNLKCijtBKKeyH984JVxjpQwOlabeA
 w7q4/5T7RTLzrdwhvaDw0oSlbytymg7DzaT07+EqfmVJHAxg0H1PMESDgRN0XaGEItaZX73vx
 /+hfQj63fSMP57OlCXveAab3Nd6o7gPFWUlQcUVbUrF1Dh58CMi8kTkdysv8K2EXTkgi9/3CV
 hekw4yJrHU9n5a8isQkiyAkAY02msv6jr+GFr8SrHBJZVPB7RUjWwaz3mzGI/HCTqnvWhEm4h
 3aQjSTkq0klSgRR3/Oskqw31mek8k7yd4xAMzZ/X5zkzvpt9HzW8AeSpNjefw+QJfPhST7Rpi
 FlnNvLDlz6r/pfulJ1Y18u/bu3WQqzgO759M0RY+mB1C1UJ03O1qQb7i+gS4amd7tlf6sJjIF
 /iEfgTP7j4fFXLaIiktAa2zHRUEYJ6/sDsjBS3CRBbWaqZ9Vs7BLT9PxKoIswhr9015Bei2xM
 TIEuEUVOx6gYLTf3TVB37fzqre/FYVwFKC7ol02YGKjQ8uF4Lek1g+RVwaHLlLd88irtd3VEF
 EWWq2Hvp6Ie9Iqlx/SgmLUeLQ6sF9mzCp1uQAR5fGzKDUaA4M3N18VVrMjk5oPc/g/gGCMO0l
 QY3mF2WTQgC4dNT33IxFKu7rnVNnY+xmyZDkGuuXwEpINNSWME3p6JatwF+DuDHJJISQfLxnQ
 zsbYrT0bJtNsVP2ZqfQkeQiAUffcQKRMw/PyjteLljBtpiv3mryeGZo+tXWuiNPYGurKaMpbu
 54zZHRzrYpPAZ/FuC8LQaOepspUaS4nTzFRUtj7YUvTWiUiUyrg3frfFtnp15sWRo9Dtiec
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 08:03:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/06/2020 à 13:05, Chen Gang a écrit :
> On 2020/6/3 下午5:49, Laurent Vivier wrote:
>> Le 03/06/2020 à 03:08, chengang@emindsoft.com.cn a écrit :
>>> +#ifdef HAVE_DRM_H
>>> +
>>> +static void unlock_drm_version(struct drm_version *host_ver)
>>> +{
>>> +    if (host_ver->name) {
>>> +        unlock_user(host_ver->name, 0UL, 0);
>>
>> unlock_user() allows to have a NULL host pointer parameter, so you don't
>> need to check. But you must provide the target pointer, with the length.
>> The same below.
>>
> 
> As far as I know, the unlock_user is defined in
> include/exec/softmmu-semi.h, which only checks the len before calling
> cpu_memory_rw_debug, and only calls free() for the host pointer.
> 
> So we have to be sure that the host pointer must be valid. When we pass
> 0 length to unlock_user, we want it to free host pointer only.

No, it is defined in our case in linux-user/qemu.h, and associated
comment is:

/* Unlock an area of guest memory.  The first LEN bytes must be
   flushed back to guest memory. host_ptr = NULL is explicitly
   allowed and does nothing. */

> 
>>> +    if (host_ver->desc_len) {
>>> +        host_ver->desc = lock_user(VERIFY_WRITE, target_ver->desc,
>>> +                                   target_ver->desc_len, 0);
>>> +        if (!host_ver->desc) {
>>> +            goto err;
>>> +        }
>>> +    }
>>> +
>>> +    unlock_user_struct(target_ver, target_addr, 0);
>>> +    return 0;
>>> +err:
>>> +    unlock_drm_version(host_ver);
>>> +    unlock_user_struct(target_ver, target_addr, 0);
>>> +    return -ENOMEM;
>>
>> In fact it should be -TARGET_EFAULT: it has failed because of access rights.
>>
> 
> As far as I know, the lock_user is defined in
> include/exec/softmmu-semi.h. If the parameter 'copy' is 0 (in our case),
> lock_user will only malloc a host pointer and return it.

No, in linux-user/qemu.h:

/* Lock an area of guest memory into the host.  If copy is true then the
   host area will have the same contents as the guest.  */

> In our case, I guess the only failure from malloc() is "no memory".

See use-cases in syscall.c, they all fail with -TARGET_EFAULT.

Thanks,
Laurent

