Received: from eggs.gnu.org ([209.51.188.92]:47526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggkXH-0007Z9-2f
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggkXG-0002XX-1c
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:06:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggkXE-0002Qg-8V
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:06:45 -0500
Date: Tue, 8 Jan 2019 07:06:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190108060641.2diwma66c33dymti@sirius.home.kraxel.org>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<26b300d6c17e6ac015f1519d50151744cf806c03.1545598229.git.DirtY.iCE.hu@gmail.com>
	<87sgy4k3u7.fsf@dusky.pond.sub.org>
	<b050b973-e675-8114-fd8a-1878dbdb81d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b050b973-e675-8114-fd8a-1878dbdb81d6@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/52] audio: -audiodev command line
 option basic implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> > I suspect your series uses the options visitor only because back when
> > you started, qobject_input_visitor_new_str() didn't exist.
> 
> Yes, this patch series is a bit old, and at that time this was the best
> I could do. I can look into it this (probably only on the weekend
> though), it looks like it supports foo.bar=something syntax, so I don't
> have to specify a json on the command line...

It supports both, i.e. this ...

    qemu -display gtk,full-screen=on

... and this ...

    qemu -display '{ "type": "gtk", "full-screen": true }'

... has the same effect.

cheers,
  Gerd
