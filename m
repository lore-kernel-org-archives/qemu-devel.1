Received: from eggs.gnu.org ([209.51.188.92]:44948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk73b-0003ou-OS
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk73a-0008OJ-Vl
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:46:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gk73a-0008Js-QG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:46:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190117073649.5399.97670.stgit@pasha-VirtualBox>
	<20190117073736.5399.81520.stgit@pasha-VirtualBox>
Date: Thu, 17 Jan 2019 13:45:54 +0100
In-Reply-To: <20190117073736.5399.81520.stgit@pasha-VirtualBox> (Pavel
	Dovgalyuk's message of "Thu, 17 Jan 2019 10:37:36 +0300")
Message-ID: <877ef34flp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 08/24] migration: introduce icount
 field for snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> Saving icount as a parameters of the snapshot allows navigation between
> them in the execution replay scenario.
> This information can be used for finding a specific snapshot for proceeding
> the recorded execution to the specific moment of the time.
> E.g., 'reverse step' action (introduced in one of the following patches)
> needs to load the nearest snapshot which is prior to the current moment
> of time .
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

QAPI schema part
Acked-by: Markus Armbruster <armbru@redhat.com>
