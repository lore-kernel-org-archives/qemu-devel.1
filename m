Received: from eggs.gnu.org ([2001:4830:134:3::10]:49990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1gRghE-0002gM-HS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1gRggN-0005iT-V8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:58:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1gRggN-0005ht-LN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:57:55 -0500
Date: Tue, 27 Nov 2018 16:57:35 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20181127165735.jh6iwd2znxanvgj7@starbug-mbp.local>
References: <1543312923-3074-1-git-send-email-liq3ea@gmail.com>
	<1543312923-3074-3-git-send-email-liq3ea@gmail.com>
	<20181127102736.q2322bc6uw4wvvif@starbug-mbp.local>
	<87a7lur8z8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <87a7lur8z8.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw: vmmouse: drop DEFINE_PROP_PTR()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, ehabkost@redhat.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Tue, Nov 27, 2018 at 01:38:35PM +0100, Markus Armbruster wrote:
>Darren Kenny <darren.kenny@oracle.com> writes:
>
>> Hi Li Qiang,
>>
>> This is only a suggestion, I'm sure someone else might also correct
>> me, but I'm not sure the subject above really describes what is
>> happening in the commit as a whole.
>>
>> It seems to miss the point that the main change here is to use a
>> link type property, so maybe it might be better written as something
>> along the lines of:
>>
>>  Subject: [PATCH v2 2/2] hw: vmmouse: use link property instead of pointer
>>  Drop DEFINE_PROP_PTR() and replace with a link pointer via an
>>  instance init function (vmmouse_instance_initfn).
>
>Yes, that's better.  Or take inspiration from recent similar work, such
>as commit a8299ec1b24, and say something like
>
>    vmmouse: Use link instead of pointer property
>
>    According to qdev-properties.h, properties of pointer type should
>    be avoided.  Turn "ps2_mouse" into a link.
>
>Preferably with the commit message improved along these lines:
>Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>[...]
>

With something like that,

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.
