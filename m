Received: from eggs.gnu.org ([2001:4830:134:3::10]:45150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4XI-0003Mv-Kb
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4XD-0006mn-Rt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:25:44 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:39137)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4XD-0006mg-Ir
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:25:39 -0400
Date: Wed, 12 Jul 2017 01:24:52 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170711232452.hqcpcbubep7iyjwf@var.youpi.perso.aquilenet.fr>
References: <1496679576-14336-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496679576-14336-2-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [1/2] slirp: Handle error returns from
 slirp_send() in sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, patches@linaro.org

Peter Maydell, on lun. 05 juin 2017 17:19:35 +0100, wrote:
> The code in sosendoob() assumes that slirp_send() always
> succeeds, but it might return an OS error code (for instance
> if the other end has disconnected). Catch these and return
> the caller either -1 on error or the number of urgent bytes
> actually written. (None of the callers check this return
> value currently, though.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Applied to my tree, thanks!
