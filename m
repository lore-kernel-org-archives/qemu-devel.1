Received: from eggs.gnu.org ([2001:4830:134:3::10]:39775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3dk-0004oX-Bc
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3dj-0005LG-Mw
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:34:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3dj-0005Kz-Hg
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:34:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-14-armbru@redhat.com>
	<1c126eed-8b47-b61a-69d8-38176e1e586d@redhat.com>
Date: Mon, 30 Jul 2018 10:34:49 +0200
In-Reply-To: <1c126eed-8b47-b61a-69d8-38176e1e586d@redhat.com> (Eric Blake's
	message of "Fri, 27 Jul 2018 10:48:33 -0500")
Message-ID: <87wotdxgt2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 13/23] tests: Clean up string
 interpolation around qtest_qmp_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

[...]
> (We really want to assert that any % interpolations in our JSON parser
> are NOT embedded in '').

I'll look into that, but it'll be in a separate series.

[...]
