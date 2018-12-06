Received: from eggs.gnu.org ([2001:4830:134:3::10]:33445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUzqb-0003xy-Q7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUzqV-0001vM-MI
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:02:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUzqT-0001pb-Cx
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:02:03 -0500
References: <20181203164105.29858-1-berrange@redhat.com>
	<08d36eda-e8e7-4ece-edc5-ef436d25e6b7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86756391-b9b7-12d0-f6ec-8766ea7ab4d7@redhat.com>
Date: Thu, 6 Dec 2018 21:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <08d36eda-e8e7-4ece-edc5-ef436d25e6b7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Import historical documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Jeff Cody <codyprime@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 04/12/18 11:56, Thomas Huth wrote:
> I think it would be best if we find a way to automate this process, e.g=
.
> when a new release is tagged, a script generates the docs and puts them
> somewhere on the web server, into the right new folder based on the nam=
e
> of the tag. However, I don't know the qemu server well enough to know
> whether that's possible or not ... maybe Jeff or Paolo can comment on
> this...

There are two possibilities: putting the docs on download.qemu.org and
going for Marc-Andr=C3=A9's styling solution, or using a dash of sed to
remove the <head> and use Jekyll to generate the page.

Either way, there isn't much to do on the webserver side, so a better
person to ask would be Mike Roth as he's the Guy Who Does The Releases.
For either solution he'd have to build the documentation and scp it (if
we go for download.qemu.org) or commit it to qemu-web.git (if we go for
Jekyll).  I guess he has scripts already to automate part of the release
process, but I have no idea if the website update is automated already.

Paolo
