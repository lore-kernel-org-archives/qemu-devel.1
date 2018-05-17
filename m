Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJJIw-0006PK-1A
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJJIt-0000RP-00
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:50:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJJIs-0000R3-PV
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:50:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F23CA401EF08
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:50:45 +0000 (UTC)
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
	<20180517124403.GJ5657@redhat.com>
	<20180517125110.lhipiezmvifrg3n6@sirius.home.kraxel.org>
	<6e0213c3-017e-c794-a222-fde38676d7c8@redhat.com>
	<20180517134559.uwne63xmqh2lucwq@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e54a1bf7-b154-844e-875c-87690754b7c0@redhat.com>
Date: Thu, 17 May 2018 15:50:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180517134559.uwne63xmqh2lucwq@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

On 17/05/2018 15:45, Gerd Hoffmann wrote:
>   Hi,
> 
>>> Related: can modules depend on modules, so we could make x_keymap a
>>> module of its own and have both gtk and sdl depend on it?
>>>
>>> That would also be useful when trying to modularize spice.
>>
>> How hard would it be to modularize the libspice-server side?  The part
>> of the library that is used by QXL rendering should have much fewer
>> dependencies than the part that is used for keyboard, mouse, audio,
>> vmchannel/agent, etc.
> 
> kbd, mouse, audio is needed on the client side and is not part of
> libspice-server anyway.

Yes, I'm talking about separating the client side from the QXL rendering
part.

>  So spice is much less of a burden compared
> to sdl/gtk which bring alot of ui toolkit deps.

But SPICE does bring in 16 libraries, including both of NSS and OpenSSL...

Paolo
