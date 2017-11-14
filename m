Received: from eggs.gnu.org ([2001:4830:134:3::10]:37619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEhrA-0000NR-H1
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEhr9-0003gG-MR
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:30:52 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
	<94700229-5afe-159f-9453-f507b9c83085@redhat.com>
	<0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
	<9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
	<1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
	<20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e76811c5-6a5a-cf5e-2571-9e112e609740@redhat.com>
Date: Tue, 14 Nov 2017 15:30:26 -0500
MIME-Version: 1.0
In-Reply-To: <20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>



On 11/14/2017 01:46 PM, Max Reitz wrote:
> On 2017-11-14 19:45, Thomas Huth wrote:
>> On 14.11.2017 14:32, Max Reitz wrote:
>> [...]
>>> Well, do you want to document it?  I'd rather deprecate it altogether.
>>
>> Maybe a first step could be to change qemu-img so that it refuses to
>> create new qcow1 images (but still can convert them into other formats).
>> So basically make qcow1 read-only?
> 
> Yep, and the actual first step to that is to make it issue a deprecation
> warning when creating qcow v1 images (which is what I proposed). :-)
> 
> Max
> 

Deprecation warning is good.

In future versions you can shimmy it behind a
--no-really-I-want-this-old-format option, I think we ought to support
creating the images for as long as is technologically convenient.
