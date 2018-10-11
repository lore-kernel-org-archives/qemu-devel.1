Received: from eggs.gnu.org ([2001:4830:134:3::10]:33157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gAeMK-0007Q0-GB
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gAeMJ-0001lW-NA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:02:48 -0400
Date: Thu, 11 Oct 2018 14:02:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181011170235.GS5738@habkost.net>
References: <20181010213102.8373-1-f4bug@amsat.org>
	<20181011113340.GA4417@localhost.localdomain>
	<ff422e9b-fd56-1be1-68cf-300dcd7a0cb4@redhat.com>
	<877eio37m2.fsf@dusky.pond.sub.org>
	<20181011145604.GA23047@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011145604.GA23047@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] python: Use io.StringIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, Oct 11, 2018 at 04:56:04PM +0200, Kevin Wolf wrote:
> Am 11.10.2018 um 16:01 hat Markus Armbruster geschrieben:
[...]
> > I think we need to invest more resources in Python 2/3 compatiblity, or
> > else we'll miss our hard deadline of January 1, 2020.
> 
> Did we decide until when we want to support Python-2-only hosts in QEMU?
> 
> I think I would be okay with just getting rid of Python 2 support and
> always using Python 3 instead of trying to write code that works with
> both. Python 3 was installed for me, but the scripts didn't use it.

I'd like to drop Python 2 support on QEMU 3.1.

-- 
Eduardo
