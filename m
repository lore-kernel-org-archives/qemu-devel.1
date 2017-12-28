Received: from eggs.gnu.org ([2001:4830:134:3::10]:54922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eURg3-0004ou-M1
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 01:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eURg2-0004Gq-RM
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 01:28:27 -0500
Date: Thu, 28 Dec 2017 14:28:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171228062810.GK9192@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-13-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220154945.88410-13-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 12/13] iotests: add dirty bitmap
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> +def inject_test_case(klass, name, method, *args, **kwargs):
> +    mc = operator.methodcaller(method, *args, **kwargs)
> +    setattr(klass, 'test_' + name, new.instancemethod(mc, None, klass))
> +
> +
> +for cmb in list(itertools.product((True, False), repeat=4)):
> +    name = ('_' if cmb[0] else '_not_') + 'persistent_'
> +    name += ('_' if cmb[1] else '_not_') + 'shared_'
> +    name += ('_' if cmb[2] else '_not_') + 'migbitmap_'
> +    name += '_online' if cmb[3] else '_offline'
> +
> +    inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration', *cmb)

Personally I'd just spell out the 16 method names and call do_test_migration.
It's much easier to read and modify. Either way,

Reviewed-by: Fam Zheng <famz@redhat.com>
