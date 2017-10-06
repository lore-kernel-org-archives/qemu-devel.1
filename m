Received: from eggs.gnu.org ([2001:4830:134:3::10]:41431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Swj-0007BV-Mm
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0Swj-0001iq-0B
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:45:45 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:55563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0Swi-0001h5-S4
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:45:44 -0400
Received: by mail-qt0-x22d.google.com with SMTP id x54so31405276qth.12
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:45:44 -0700 (PDT)
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-21-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f016c5f-4e1a-e0bf-c8d9-ab28f5f1cb1a@linaro.org>
Date: Fri, 6 Oct 2017 09:45:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170928203708.9376-21-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/30] s390x/tcg: implement SIGP SENSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 09/28/2017 04:36 PM, David Hildenbrand wrote:
> Add it as preparation for TCG. Sensing coul later be done completely
> lockless.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/sigp.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
