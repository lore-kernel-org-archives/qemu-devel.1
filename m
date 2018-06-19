Received: from eggs.gnu.org ([2001:4830:134:3::10]:40151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVHUr-0008UJ-Ll
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVHUm-0006te-PE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:20:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVHUm-0006t8-LI
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:20:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-8-peterx@redhat.com>
Date: Tue, 19 Jun 2018 16:20:30 +0200
In-Reply-To: <20180619053426.13065-8-peterx@redhat.com> (Peter Xu's message of
	"Tue, 19 Jun 2018 13:34:26 +0800")
Message-ID: <87vaaen9ht.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 7/7] Revert "tests: Add parameter to
 qtest_init_without_qmp_handshake"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> This reverts commit ddee57e0176f6ab53b13c6c97605b62737a8fd7a.
>
> Meanwhile, revert one line from fa198ad9bdef to make sure
> qtest_init_without_qmp_handshake() will only pass in one parameter.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
