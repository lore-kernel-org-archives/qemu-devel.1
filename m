Received: from eggs.gnu.org ([2001:4830:134:3::10]:32929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDZEV-0000PC-Aq
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDZEU-0003SH-O4
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:33:59 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDZEU-0003Rs-JR
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:33:58 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so27187308qke.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 09:33:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1495616063-19386-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <842ed88a-28f7-dd3a-e350-fe065cb4d7ea@twiddle.net>
Date: Wed, 24 May 2017 09:33:54 -0700
MIME-Version: 1.0
In-Reply-To: <1495616063-19386-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x/cpu_models: Allow some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 05/24/2017 01:54 AM, Thomas Huth wrote:
> feats[] = {
> +        S390_FEAT_STFLE,
> +        S390_FEAT_EXTENDED_IMMEDIATE,
> +        S390_FEAT_LONG_DISPLACEMENT,
> +        S390_FEAT_LONG_DISPLACEMENT_FAST,
> +        S390_FEAT_STORE_CLOCK_FAST,
> +        S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
> +        S390_FEAT_EXECUTE_EXT,
> +        S390_FEAT_STFLE_45,
> +    };

static const.


r~
