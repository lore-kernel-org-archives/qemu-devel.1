Received: from eggs.gnu.org ([2001:4830:134:3::10]:54628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0Xve-0004PF-FY
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0XvV-0002ke-FD
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:09:28 -0400
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
	<ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
	<f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
	<56133002-7a79-bf6a-8835-fba043638224@redhat.com>
	<81bba910-3e33-376d-f490-151fcccd4322@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7fc2563-00f1-db67-8635-e15a6087d988@redhat.com>
Date: Thu, 13 Sep 2018 15:06:54 -0500
MIME-Version: 1.0
In-Reply-To: <81bba910-3e33-376d-f490-151fcccd4322@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Can I only commit from active image to
 corresponding range of its backing file by qemu cmd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 9/13/18 2:41 PM, Max Reitz wrote:
> On 13.09.18 20:37, Max Reitz wrote:
> 
> [...]
> 
>> Or, we would have to use backing=null, but for some reason that doesn't
>> work.  I'll have to investigate.
> 
> Turns out this was fixed in e59a0cf17b1b9932b65e6fc25d6856976f5e4831.
> 
> (Why does Fedora still have only qemu 2.11?)

Fedora 28 + virtmaint-sig-virt-preview COPR has qemu 3.0.  Come join us 
on the bleeding edge :)

> So starting with 2.12, putting a "'backing':null" behind
> "'driver':'qcow2," will work just as well as rebasing img.003.

Good to hear.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
