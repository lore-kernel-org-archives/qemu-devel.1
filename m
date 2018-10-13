Received: from eggs.gnu.org ([2001:4830:134:3::10]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gBKuH-0007L6-Rq
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 10:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gBKuH-00034E-4U
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 10:28:41 -0400
References: <20181013050227.17022-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <30a1d2bf-011e-01b0-ccf1-a9f5bef6c5bd@redhat.com>
Date: Sat, 13 Oct 2018 09:28:27 -0500
MIME-Version: 1.0
In-Reply-To: <20181013050227.17022-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/13/18 12:02 AM, Eduardo Habkost wrote:
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

Commit message is sparse; can you do something like commit e7b3af81 
where you call out the availability of python 3 on all the platforms 
that are currently supported per our platforms doc?

> I'd like to do this in QEMU 3.1.  I think it's time to drop
> support for old systems that have only Python 2.
> 
> We still have a few scripts that are not required for building
> QEMU that still work only with Python 2 (iotests being the most
> relevant set).  Requiring Python 3 for building QEMU won't
> prevent people from using those scripts with Python 2 until they
> are finally ported.

How much effort is it to complete the porting?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
