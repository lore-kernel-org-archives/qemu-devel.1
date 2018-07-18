Received: from eggs.gnu.org ([2001:4830:134:3::10]:41805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffnyk-0008Hm-4b
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffnyf-00071K-N0
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:02:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180717234015.22700-1-f4bug@amsat.org>
	<20180718145312.GZ31657@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8fbaf02a-752c-2fec-5bbd-9b31839ce19a@amsat.org>
Date: Wed, 18 Jul 2018 12:02:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180718145312.GZ31657@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] qemu-iotests: Adapt to moved
 location of StringIO module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>

Hi Eduardo,

On 07/18/2018 11:53 AM, Eduardo Habkost wrote:
> On Tue, Jul 17, 2018 at 08:40:15PM -0300, Philippe Mathieu-Daudé wrote:
> [...]
>> -    import StringIO
>> +    try:
>> +        from StringIO import StringIO
>> +    except ImportError:
>> +        from io import StringIO
> 
> Why do we need this?  Python 2.7 has io.StringIO.

Python 2 works fine, the problem is the Fedora Docker image uses Python
3 and the block tests started to fail...

Is this commit message clearer?

"Since 356dc290f the Fedora [Docker] image uses Python3 by default."
