Received: from eggs.gnu.org ([2001:4830:134:3::10]:53830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1UY-0003Jf-F7
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1UT-0004fA-Jf
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:22:10 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dR1UT-0004ej-DH
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:22:05 -0400
Received: by mail-qt0-x244.google.com with SMTP id v31so16240791qtb.3
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:22:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170627161032.5014-1-david@redhat.com>
	<251b8047-7df4-50a5-cce7-b66858c781a1@redhat.com>
	<4c7a78bc-ec7f-9873-0bda-f3c8e76c844b@redhat.com>
	<3373125e-171a-0516-90f0-757d60eba32a@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <449afc6c-1fbc-9ae9-8450-9c9a9e67f2c8@twiddle.net>
Date: Fri, 30 Jun 2017 12:22:01 -0700
MIME-Version: 1.0
In-Reply-To: <3373125e-171a-0516-90f0-757d60eba32a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpumodel: allow to enable "idtes"
 feature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>

On 06/29/2017 12:05 AM, Thomas Huth wrote:
> However, I'm not sure whether you can simply ignore the clearing-by-ASCE
> stuff in this case. For example, according to the PoP:
> 
> "When the clearing-by-ASCE-option bit (bit 52 of gen-
>   eral register R2 is one), the M4 field is ignored."
> 
> And the idte helper function currently always takes the M4 field into
> account...

I don't see that quote.  I see only

    Bit 2 of the M 4 field is ignored for the
    clearing-by-ASCE operation and when EDAT-2
    does not apply.

We don't actually handle bit 2 at all...


r~
