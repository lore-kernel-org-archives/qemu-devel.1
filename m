Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C0FC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0712206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0712206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYQbw-0005jr-Bb
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 03:45:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hYQb4-0005Ou-Ml
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hYQb3-00012v-CG
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:44:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>)
	id 1hYQb0-0000gb-VZ; Wed, 05 Jun 2019 03:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76B3867F;
	Wed,  5 Jun 2019 07:44:02 +0000 (UTC)
Received: from [10.40.204.44] (ovpn-204-44.brq.redhat.com [10.40.204.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB7BB60C61;
	Wed,  5 Jun 2019 07:43:57 +0000 (UTC)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
	<20190108224600.23125-10-david@gibson.dropbear.id.au>
	<759cdab3-6cf9-bb83-54f2-12d60063b15c@redhat.com>
	<6d1c8b12-0e27-b3f3-9e0e-ad68c5572ed7@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <09f7a354-b1be-48b4-15ea-4923386b6a77@redhat.com>
Date: Wed, 5 Jun 2019 09:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6d1c8b12-0e27-b3f3-9e0e-ad68c5572ed7@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 05 Jun 2019 07:44:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 09/29] target/ppc: introduce
 get_cpu_vsr{l, h}() and set_cpu_vsr{l, h}() helpers for VSR register access
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, clg@kaod.org,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/2019 08:32, Mark Cave-Ayland wrote:
> On 04/06/2019 22:23, Laurent Vivier wrote:
> 
>> This patch breaks something in the libcrypto.
>>
>> I've been able to reproduce the problem with Fedora 29:
>>
>> dnf install 'dnf-command(download)'
>> dnf download --source coreutils-single
>> rpm --verify coreutils-8.30-7.fc29.src.rpm
>> error: coreutils-8.30-7.fc29.src.rpm: Header V3 RSA/SHA256 Signature, key ID 429476b4: BAD
>> error: coreutils-8.30-7.fc29.src.rpm: Header SHA256 digest: BAD (Expected fa042669e74ac435bd5defaa8c2e4efe779a0329c24f2b6377591c53b38aa280 != d6e22527412fafc4aa12882432d0d157e5427097710eeb2d5fce8fbc52a47be6)
>> error: coreutils-8.30-7.fc29.src.rpm: not an rpm package (or package manifest)
>>
>> See https://bugzilla.redhat.com/show_bug.cgi?id=1715017
>>
>> I've tested with origin/master (47fbad45d47af8af784bb12a5719489edcd89b4c) and all the 
>> merged fixes for this patch don't fix this problem.
>>
>> We should be able to reproduce it on Debian Sid too: it breaks ssh (this is one of the rare binaries using libcrypto on debian).
>>
>> I've been able to reproduce it with qemu linux-user if I enable PPC_FEATURE2_VEC_CRYPTO in linux-user/elfload.c
>> (git clone -b linux-user-ppc64-hwcap git@github.com:vivier/qemu.git).
>>
>> To ease debugging, you can install a Fedora 29 chroot with something like:
>>
>> curl -o container.tar.xz http://download-ib01.fedoraproject.org/pub/fedora-secondary/releases/29/Container/ppc64le/images/Fedora-Container-Base-29-1.2.ppc64le.tar.xz
>> tar Jxvf container.tar.xz '*/layer.tar'
>> mkdir -p chroot/ppc64le/29
>> cd chroot/ppc64le/29
>> tar xf $OLDPWD/*/layer.tar
>> cd -
>> cp ~/qemu/ppc64le-linux-user/qemu-ppc64le chroot/ppc64le/29/
>> [use "configure --target-list=ppc64le-linux-user --static --disable-tools" and don't forget to run scripts/qemu-binfmt-conf.sh]
> 
> One of Anton's VSX patches hasn't landed in master yet and is still queued in
> ppc-for-4.1: "target/ppc: Fix lxvw4x, lxvh8x and lxvb16x".
> 
> Can you try David's ppc-for-4.1 branch first and let me know if that solves the
> issue? If not, I'll take a look at it later in the week when I have a bit more time.

Thank you Mark.

Anton's patch fixes the problem.

Thanks,
Laurent

