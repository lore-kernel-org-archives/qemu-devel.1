Received: from eggs.gnu.org ([2001:4830:134:3::10]:57300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cbxrd-0000WI-6S
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cbxra-0003Fv-1E
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 18:10:57 -0500
References: <1486638881-17290-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <20d04720-f757-3027-77a6-80981cd0a7d9@reactos.org>
Date: Fri, 10 Feb 2017 00:10:37 +0100
MIME-Version: 1.0
In-Reply-To: <1486638881-17290-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host/prep: Do not use hw_error() in
 realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

Le 09/02/2017 =E0 12:14, Thomas Huth a =E9crit :
> hw_error() is for CPU related errors only (it prints out a
> register dump and calls abort()), so we should not use it
> if we just failed to load the bios image. Apart from that,
> realize() functions should not exit directly but always set
> the errp with error_setg() in case of errors instead.
> Additionally, move some code around and delete the bios memory
> subregion again in case of such an error, so that we leave a
> clean state when returning to the caller.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/pci-host/prep.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>

Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
