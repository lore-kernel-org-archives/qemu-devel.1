Received: from eggs.gnu.org ([2001:4830:134:3::10]:58623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gV1BF-0001mR-L6
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gV1BC-0004xM-CM
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:27:33 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gV1BC-0004x1-6D
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:27:30 -0500
Received: by mail-oi1-x244.google.com with SMTP id b141so1667791oii.12
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 13:27:29 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181108141944.15769-1-minyard@acm.org>
	<20181108232211.GB26872@umbus.fritz.box>
	<8a03cead-db46-f4fb-1e57-30bec0802bc8@acm.org>
	<61eb1702-f620-9267-1dd5-e024c65a22ef@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <ec06b913-304c-a9b1-c314-350b712a9d0a@acm.org>
Date: Thu, 6 Dec 2018 15:27:26 -0600
MIME-Version: 1.0
In-Reply-To: <61eb1702-f620-9267-1dd5-e024c65a22ef@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 0/2] ipmi: Allow UUID to be set for a BMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 12/6/18 3:10 PM, Paolo Bonzini wrote:
> On 09/11/18 14:33, Corey Minyard wrote:
>> On 11/8/18 5:22 PM, David Gibson wrote:
>> I'm not sure about migration.  I suppose it could be migrated, but I
>> would consider the BMC part of the hardware that needs to be the
>> same on both sides.  It's a fuzzy line, I suppose.  The qemu UUID
>> is migrated, so I suppose that's not an issue.
>>
>> Controlling it explicitly is important for some testing I do, and might
>> be for other people at some point in time, if you are trying to
>> emulate something specific.  And when re-invoking qemu, you
>> might want to keep it the same to avoid confusing software.
> I don't understand, do you need it to be different from the dmicode
> UUID?  On real hardware are they the same or different?

They are different on real hardware, and software that uses IPMI
can expect that it doesn't change unless the BMC changes.  It's
not used that often, though.

It's often used to know that you are talking to the same BMC if
you have multiple connections (like a local connection and one
coming in over the LAN).

I primarily need it for testing things in the Linux IPMI driver,
identifying if BMCs connections are the same or not.

-corey

> Thanks,
>
> Paolo
