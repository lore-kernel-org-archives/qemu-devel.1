Received: from eggs.gnu.org ([2001:4830:134:3::10]:33873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMX6y-0004xG-Kw
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMX6v-0005RP-EA
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:44:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gMX6v-0005R3-7f
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:44:01 -0500
Date: Fri, 9 Nov 2018 19:25:29 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181109212529.GC12503@habkost.net>
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-2-crosa@redhat.com>
	<20181109154908.GW12503@habkost.net>
	<2426066f-37b0-acb8-f5f9-02fec9b6d7fa@redhat.com>
	<20181109182501.GY12503@habkost.net>
	<962bd7a4-98b4-1015-8c8a-39aaa368f1bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962bd7a4-98b4-1015-8c8a-39aaa368f1bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: keep track of Python version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On Fri, Nov 09, 2018 at 02:51:11PM -0500, Cleber Rosa wrote:
> 
> 
> On 11/9/18 1:25 PM, Eduardo Habkost wrote:
> >>
> >> "Python -V" is quite different from "sys.version".  Indeed it includes
> >> the "Python " prefix, but that's all, everything else is the version number.
> > 
> > Is this a guarantee documented somewhere?
> > 
> 
> Oops, looks like I missed that comment, and failed to address it.  Now,
> I must say I don't expect a documented guarantee about this will exist,
> but it looks like this is an acknowledged use case:
> 
> https://bugs.python.org/issue18338

Well, considering that it even has a unit test checking for a
specific format[1], I think the usage in this patch can be
considered acceptable.

[1] https://hg.python.org/cpython/rev/e6384b8b2325

-- 
Eduardo
