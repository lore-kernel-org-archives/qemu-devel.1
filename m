Received: from eggs.gnu.org ([2001:4830:134:3::10]:58562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTtvQ-00005h-CG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTtvP-0002RM-LT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:21:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTtvP-0002Qv-FT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:21:31 -0500
References: <874m0wqofz.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1deb000-5e24-89b6-2d39-a1c94cd8b1e8@redhat.com>
Date: Wed, 18 Jan 2017 18:21:29 +0100
MIME-Version: 1.0
In-Reply-To: <874m0wqofz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] SCSI HBA auto-created for -drive if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>



On 18/01/2017 18:15, Markus Armbruster wrote:
> Some boards automatically cold-plug SCSI HBAs to honor -drive if=scsi.
> Which one depends on the machine:
> 
>     pc*, realview-eb*, versatile*: lsi53c895a
>     spapr-machine: spapr-vscsi
> 
> Should we use something less thoroughly obsolete than lsi53c895a for new
> machine types?  Something that actually has a maintainer?

Or just raise an error?...

Paolo
