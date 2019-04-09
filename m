Received: from eggs.gnu.org ([209.51.188.92]:35990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hDw0P-000158-OP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hDw0O-0002hB-Qq
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hDw0O-0002e7-Ck
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:00 -0400
References: <20190307144126.31847-1-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <be62e92e-de46-b3a5-9945-a410049d25d5@redhat.com>
Date: Tue, 9 Apr 2019 20:53:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190307144126.31847-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/9] tcg: Add tcg_gen_extract2_{i32,i64}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 07.03.19 15:41, Richard Henderson wrote:
> The primary motivator here is usage within s390x,
> but (as with any good primitive) the opcode has
> applications outside that.

I am planning to send the next big part of vector instruction support
(Vector Integer Instructions) soon, that would make use of these patches.

-- 

Thanks,

David / dhildenb
