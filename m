Received: from eggs.gnu.org ([2001:4830:134:3::10]:36924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cXYnr-0001Z8-7T
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 14:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cXYnq-0005hV-7w
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 14:36:51 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cXYnq-0005h8-3E
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 14:36:50 -0500
Received: by mail-ot0-x242.google.com with SMTP id 36so34228970otx.3
	for <qemu-devel@nongnu.org>; Sat, 28 Jan 2017 11:36:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170128194157.0c82cc8a@bahia.lan>
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
	<20170128194157.0c82cc8a@bahia.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sun, 29 Jan 2017 01:06:47 +0530
Message-ID: <CAC2QTZZaaMgiiJbXgnLzBF+02=XnzKsofP7fwK7oF56maXY8Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] migrate: Migration aborts abruptly for
 machine "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sun, Jan 29, 2017 at 12:11 AM, Greg Kurz <groug@kaod.org> wrote:
> On Thu, 26 Jan 2017 14:46:52 +0530
> Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
>
>> Migration of a "none" machine with no RAM crashes abruptly as
>> bitmap_new() fails and thus aborts. Instead, place a check for
>> last_ram_offset() being '0' at the start of ram_save_setup() and
>> error out with a meaningful error message.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>

cc'ing Paolo in : I had an IRC chat with him and he has a very
interesting twist in the tale to add here.

> Maybe a naive question: why a "none" machine with zero RAM should fail to
> migrate ?

Assuming you are referring to why its failing ATM; it fails because
g_try_malloc0() inside bitmap_try_new() returns a NULL pointer for
zero bits and thus the check for NULL inside bitmap_new() becomes true
and it aborts. Check bitmap_new() for convenience.

Ignore the noise if you already knew this! :-)

Ashijeet
