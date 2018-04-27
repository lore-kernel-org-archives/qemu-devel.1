Received: from eggs.gnu.org ([2001:4830:134:3::10]:52701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fC8yI-0003Kk-1F
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fC8yD-00065y-Vg
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:23:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fC8yD-00064t-PI
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:23:49 -0400
Date: Fri, 27 Apr 2018 16:23:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180427192343.GX29865@localhost.localdomain>
References: <20180426135755.GI29865@localhost.localdomain>
	<20180427031054.GL17690@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427031054.GL17690@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yash Mankad <ymankad@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, Apr 27, 2018 at 11:10:54AM +0800, Fam Zheng wrote:
> On Thu, 04/26 10:57, Eduardo Habkost wrote:
> > So, for anybody that runs automated QEMU tests once in a while,
> > can we know:
> > 
> > * What test cases are you running?  Where can we get more
> >   information about the tests you run?
> 
> These currently run on patchew:
> 
>  * checkpatch
>  * ./configure && make (s390 host)
>  * make docker-test-mingw@fedora
>  * make docker-test-quick@centos6
>  * make docker-test-build@min-glib
> 
> 
> > * When do you run them?  What triggers a new test run?
> 
> They are run against each series posted to qemu-devel@nongnu.org. All errors are
> sent as reply to the cover letter with the concrete commands, env info and log.
> 
> (Should we create a wiki page to maintain information collected by this thread?)

I will collect this data and publish it somewhere.

(I sure yet if a wiki page would be the most practical way to
maintain it up to date.  I'm using a Google spreadsheet to keep
my notes right now.)

-- 
Eduardo
