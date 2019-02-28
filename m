Received: from eggs.gnu.org ([209.51.188.92]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzHzN-00021E-OX
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzHzJ-0002QX-6v
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:28:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzHzH-0002PR-4W
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:28:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC1E130B27D3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 09:28:16 +0000 (UTC)
Date: Thu, 28 Feb 2019 10:28:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190228092815.jmlrnriddvovrn4u@sirius.home.kraxel.org>
References: <20190225154335.11397-1-fziglio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225154335.11397-1-fziglio@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] audio: Use g_strdup_printf instead of
 manual building a string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Feb 25, 2019 at 03:43:34PM +0000, Frediano Ziglio wrote:
> Instead of using lot of low level function and manually allocate
> the temporary string in audio_process_options use more high
> level GLib function. The function is not used in hot path but to
> read some initial setting.

Added to qudio queue.

thanks,
  Gerd
