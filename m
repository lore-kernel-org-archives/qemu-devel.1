Received: from eggs.gnu.org ([2001:4830:134:3::10]:54755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gZJ60-0001FM-1j
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gZJ5z-0002ME-7X
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:23:51 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gZJ5z-0002Lp-1P
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:23:51 -0500
Received: by mail-oi1-x243.google.com with SMTP id h25so2610766oig.1
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 09:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>
	<20181218112250.11727.72640.stgit@pasha-VirtualBox>
In-Reply-To: <20181218112250.11727.72640.stgit@pasha-VirtualBox>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Tue, 18 Dec 2018 23:23:38 +0600
Message-ID: <CANzW0ms54QYPSc2bb0Sc92U+HT2RznSCiq-Wo6JzgL5iVKrWpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 20/20] replay: document development rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: alex.bennee@linaro.org, armbru@redhat.com, boost.lists@gmail.com, ciro.santilli@gmail.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, dovgaluk@ispras.ru, jasowang@redhat.com, kraxel@redhat.com, kwolf@redhat.com, maria.klimushenkova@ispras.ru, mreitz@redhat.com, mst@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, quintela@redhat.com, rth@twiddle.net, thomas.dullien@googlemail.com, war2jordan@live.com

> +Virtual devices can also use realtime clock for the events that do not
change
> +the guest state directly. When the clock ticking should depend on VM
execution
> +speed, use virtual ext clock. It is not deterministic, but its speed
depends
> +on the guest execution. This clock is used by the virtual devices (e.g.,
> +slirp routing device) that lie outside the replayed guest.

Virtual ext clock replaced with virtual clock timers having EXTERNAL
attribute.
