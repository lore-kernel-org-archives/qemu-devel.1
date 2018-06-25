Received: from eggs.gnu.org ([2001:4830:134:3::10]:42240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fXWZg-0005Kn-TP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1fXWZd-0001XI-PC
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:50:52 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:36000
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1fXWZd-0001WN-I7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:50:49 -0400
References: <1529950933-28347-1-git-send-email-thuth@redhat.com>
	<a46cbc1c-197d-1460-0f55-a918c7ff3497@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <1de1692e-ca78-d828-a81d-5c1a73a400c2@weilnetz.de>
Date: Mon, 25 Jun 2018 20:50:42 +0200
MIME-Version: 1.0
In-Reply-To: <a46cbc1c-197d-1460-0f55-a918c7ff3497@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Deprecate the -enable-hax option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Am 25.06.2018 um 20:28 schrieb Paolo Bonzini:
> On 25/06/2018 20:22, Thomas Huth wrote:
>> We currently have got three ways of turning on the HAX accelerator:
>> "-machine accel=hax", "-accel hax" and "-enable-hax". That's really
>> confusing and overloaded. Since "-accel" is our preferred way to enable
>> an accelerator nowadays, and "-accel hax" is even less to type than
>> "-enable-hax", let's deprecate the "-enable-hax" option now.
>>
>> Note: While "-enable-kvm" is available since a long time and can hardly be
>> removed since it is used in a lot of upper layer tools and scripts, the
>> "-enable-hax" option is still rather new and not very widespread yet, so
>> I think that it should be OK if we remove this in a couple of releases again
>> (we'll see whether someone complains after seeing the deprecation message -
>> then we could still reconsider to keep it if there a well-founded reasons).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Let's give this a try at least :-)
> 
> Sounds good, queued.
> 
> Paolo
> 

Reviewed-by: Stefan Weil <sw@weilnetz.de>

I would not mind if --enable-hax were removed soon, as I don't think it
was widely used.

Stefan
