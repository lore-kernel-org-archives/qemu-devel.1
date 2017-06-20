Received: from eggs.gnu.org ([2001:4830:134:3::10]:34613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNMtq-0000r8-S5
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNMtl-0005p8-QJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:25:10 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:35167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNMtl-0005p1-Jq
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:25:05 -0400
Received: by mail-pf0-x22d.google.com with SMTP id c73so12197608pfk.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 10:25:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170620123553.16186-1-david@redhat.com>
	<20170620123553.16186-2-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <301234db-ca25-555c-7d87-6a6bce53094e@twiddle.net>
Date: Tue, 20 Jun 2017 10:25:02 -0700
MIME-Version: 1.0
In-Reply-To: <20170620123553.16186-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] target/s390x: Indicate and check
 for local tlb clearing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com

On 06/20/2017 05:35 AM, David Hildenbrand wrote:
> +    if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING) && (m4 & 1)) {

Surely better to let m4 == 0 without local-tlb-clearing during translate.


r~
