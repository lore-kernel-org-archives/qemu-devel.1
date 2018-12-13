Received: from eggs.gnu.org ([2001:4830:134:3::10]:45855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gXZqF-0004Ix-Qh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gXZqF-0005CJ-2L
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:52:27 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181213223737.11793-1-pbonzini@redhat.com>
	<20181213223737.11793-3-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <36c3564c-76f4-b306-e74f-234f16e62aa2@twiddle.net>
Date: Thu, 13 Dec 2018 16:52:13 -0600
MIME-Version: 1.0
In-Reply-To: <20181213223737.11793-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] avoid TABs in files that only contain
 a few
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Fam Zheng <famz@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "open list:bochs" <qemu-block@nongnu.org>, "open list:Stellaris" <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:ppc4xx" <qemu-ppc@nongnu.org>

On 12/13/18 4:37 PM, Paolo Bonzini wrote:
> Most files that have TABs only contain a handful of them.  Change
> them to spaces so that we don't confuse people.


Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
