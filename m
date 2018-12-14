Received: from eggs.gnu.org ([2001:4830:134:3::10]:38549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXgeh-0007OF-Tl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXgeh-0004Fe-7p
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 01:08:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181213223737.11793-1-pbonzini@redhat.com>
	<20181213223737.11793-2-pbonzini@redhat.com>
Date: Fri, 14 Dec 2018 07:08:49 +0100
In-Reply-To: <20181213223737.11793-2-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Thu, 13 Dec 2018 23:37:36 +0100")
Message-ID: <87bm5ofxn2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] remove space-tab sequences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, "open list:ARM target" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Richard Henderson <rth@twiddle.net>

Paolo Bonzini <pbonzini@redhat.com> writes:

> There are not many, and they are all simple mistakes that ended up
> being committed.  Remove them.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

The cover letter states "I am not touching space-tab in the middle of
the line, many of which are in #define lines."  I think the actual
commit should, too.
