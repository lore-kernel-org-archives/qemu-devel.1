Received: from eggs.gnu.org ([209.51.188.92]:51162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd30-0001De-1T
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd2y-0003FV-Fv
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:19:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmd2w-0002yA-FU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:19:48 -0500
Date: Thu, 24 Jan 2019 12:19:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124111922.j2dduwjpm76con7w@sirius.home.kraxel.org>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<da5485bb1a115b2cfd3a4484cb5f351c026ae4db.1547681517.git.DirtY.iCE.hu@gmail.com>
	<20190117092212.ccv7zv4snnuanxtw@sirius.home.kraxel.org>
	<75f937a5-4ab7-fdf5-f14c-e1ec87226c4a@gmail.com>
	<20190124074224.vuwxr6gith4txvmj@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124074224.vuwxr6gith4txvmj@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v3 15/50] audio: reduce glob_audio_state
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org

  Hi,

> So, I think with the first part the only open issue is whenever we go
> with the nested types (i.e. patch #1 as-is) or not.  Given that the
> one-element-structs added in that patch will get additional fields I
> think the nesting makes sense.

Spoke too soon: scripts/checkpatch.pl flags a bunch of codestyle issues.

cheers,
  Gerd
