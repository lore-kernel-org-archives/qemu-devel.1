Received: from eggs.gnu.org ([2001:4830:134:3::10]:57151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb6RG-00013p-9I
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb6RB-0007jE-8T
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:12:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eb6RB-0007ic-36
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:12:37 -0500
Date: Mon, 15 Jan 2018 16:12:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180115151226.dwa35lcdhik744t5@sirius.home.kraxel.org>
References: <20171212142500.3909-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212142500.3909-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] Convert apple related code to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Peter Maydell ]" <peter.maydell@linaro.org>, Programmingkid <programmingkidx@gmail.com>

On Tue, Dec 12, 2017 at 02:24:58PM +0000, Daniel P. Berrange wrote:
> This is a followup to
> 
>   v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02047.html
>   v2: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02471.html
>   v3: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02517.html
>   v4: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02708.html
>   v5: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02950.html
> 
> This series contains only the apple related patches, the cocoa frontend
> and adb backend device.
> 
> I decided to separate them, as I'm fairly sure the keycodemapdb data for
> these has some problems in it. There is contradictory information on the
> right mappings to use for certain keys. Looking at darwin source code
> in fact I think that the low level hardware scancode -> keycode mappings
> on OS-X might even change based on user config options at the OS level,
> and I'm not sure how to deal with that yet.
> 
> So I need todo more investigation before I consider these two patches
> ready for merge. They're just posted to allow any feedback to be gathered

Doesn't apply any more, can you rebase?

thanks,
  Gerd
