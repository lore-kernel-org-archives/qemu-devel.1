Received: from eggs.gnu.org ([2001:4830:134:3::10]:53330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMZvJ-00057p-Au
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMZvH-00014n-1l
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:44:13 -0500
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
	<20181113121836.GC4830@localhost.localdomain>
	<20181113132653.GG12503@habkost.net>
	<20181113135116.GE4830@localhost.localdomain>
	<a596c3a8-9099-391d-f418-4600e0e614f0@redhat.com>
	<20181113143223.GK12503@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <88fd00ad-fef7-6233-c458-bc9c712e510b@redhat.com>
Date: Tue, 13 Nov 2018 09:43:49 -0500
MIME-Version: 1.0
In-Reply-To: <20181113143223.GK12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>


On 11/13/18 9:32 AM, Eduardo Habkost wrote:
> On Tue, Nov 13, 2018 at 09:20:11AM -0500, Cleber Rosa wrote:
> 
> With check-venv, we made "installing avocado" a small
> implementation detail that people don't need to care about when
> running the tests.
> 
> I believe the sentence "which must be installed separately" is
> now confusing and misleading.  It can be easily interpreted as
> "must be installed manually by the user", which is not case.
> 

Yeah, it can be confusing.  Maybe something like:

These tests are written using the Avocado Testing Framework (which must
either be manually installed, or automatically as part of ``make
check-acceptance``)...

- Cleber.
