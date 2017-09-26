Received: from eggs.gnu.org ([2001:4830:134:3::10]:44838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwhOL-0003qO-AL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwhOI-0002gj-6k
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:22:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwhOI-0002gL-1b
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 00:22:38 -0400
References: <1504729728-23279-1-git-send-email-cota@braap.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c9b8e5af-3ccb-5747-78b4-de8e11e5e081@redhat.com>
Date: Tue, 26 Sep 2017 06:22:31 +0200
MIME-Version: 1.0
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On 06.09.2017 22:28, Emilio G. Cota wrote:
> Related threads:
>   [PATCH 00/13] instrument: Add basic event instrumentation
>   Date: Mon, 24 Jul 2017 20:02:24 +0300
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
> and
>   [PATCH v4 00/20] instrument: Add basic event instrumentation
>   Date:	Wed, 6 Sep 2017 20:22:41 +0300
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
>=20
> This set does something similar to the instrumentation patches by Lluis=
,
> but with a different implementation (and for now less events).
>=20
> My focus has been on working on the skeleton of a (pseudo) stable API,
> as Stefan requested. Of course more events would have to be added, but
> before spending more time on this I'd like to get some feedback on the
> core of the design. Patch 2 has all the details.

Sorry for my ignorance, but if you send a patch series like this, could
you please elaborate a little bit more on the topic what this all is
about? In this cover letter, you basically give only some pointers about
other patch series and point the reader to patch 2, but also patch 2
does not really have a proper *description* of what this is really all
about. Sure, it's about plugins, but what kind of plugins? Audio? Video?
CPU? Everything? If you send RFC, you should properly describe your
vision first, and maybe give some examples, before you jump into the
details.

 Thanks,
  Thomas
