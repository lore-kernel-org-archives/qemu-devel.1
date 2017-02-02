Received: from eggs.gnu.org ([2001:4830:134:3::10]:47051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ5fb-00088v-3N
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 19:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ5fY-00035W-2m
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 19:54:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZ5fX-000359-T4
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 19:54:36 -0500
References: <1485954928-22287-1-git-send-email-den@openvz.org>
	<20170201135306.GI3232@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9e50c49-4a25-ad69-0317-08e99b8fada1@redhat.com>
Date: Wed, 1 Feb 2017 16:54:28 -0800
MIME-Version: 1.0
In-Reply-To: <20170201135306.GI3232@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu_char: socket backend: disconnect
 on EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>



On 01/02/2017 05:53, Daniel P. Berrange wrote:
>>  
>> +        if (ret < 0 && errno == EPIPE) {
> IMHO you should just remove "&& errno == EPIPE" and it'd be fine.

It should be errno != EAGAIN.

Paolo

>> +            if (tcp_chr_read_poll(chr) <= 0) {
>> +                tcp_chr_disconnect(chr);
>> +                return len;
>> +            } /* else let the read handler finish it properly */
>> +        }
