Received: from eggs.gnu.org ([2001:4830:134:3::10]:58137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1espVt-0000gm-Dd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1espVp-0006CF-Gk
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:46:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1espVp-0006Bu-Be
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:46:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A30758182D3A
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 12:46:40 +0000 (UTC)
Date: Mon, 5 Mar 2018 13:46:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180305124639.i236poptdzbdamhj@sirius.home.kraxel.org>
References: <1520248105-10053-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1520248105-10053-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] Allow to specify a display device ID
 and head whith the screendump command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On Mon, Mar 05, 2018 at 12:08:25PM +0100, Thomas Huth wrote:
> QEMU's screendump command can only take dumps from the primary display.
> When using multiple VGA cards, there is no way to get a dump from a
> secondary card or other display heads yet. So let's add an 'device' and
> a 'head' parameter to the HMP and QMP commands to be able to specify
> alternative devices and heads with the screendump command, too.
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd

PS: With an ack from qom folks I can take this through the ui patch
    queue, alternatively feel free to put this into the qom queue.
