Received: from eggs.gnu.org ([2001:4830:134:3::10]:39558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEhyH-0002j2-JX
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEhyG-0008Gn-Lv
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:38:13 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
	<94700229-5afe-159f-9453-f507b9c83085@redhat.com>
	<0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
	<9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
	<1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
	<20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
	<e76811c5-6a5a-cf5e-2571-9e112e609740@redhat.com>
	<89062bb7-f2fa-db5e-d799-c61e1daa6b99@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3db6cc30-f744-7a47-e59a-6a15c9fcfd39@redhat.com>
Date: Tue, 14 Nov 2017 15:38:05 -0500
MIME-Version: 1.0
In-Reply-To: <89062bb7-f2fa-db5e-d799-c61e1daa6b99@redhat.com>
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



On 11/14/2017 03:35 PM, Max Reitz wrote:
> On 2017-11-14 21:30, John Snow wrote:
>>
>>
>> On 11/14/2017 01:46 PM, Max Reitz wrote:
>>> On 2017-11-14 19:45, Thomas Huth wrote:
>>>> On 14.11.2017 14:32, Max Reitz wrote:
>>>> [...]
>>>>> Well, do you want to document it?  I'd rather deprecate it altogether.
>>>>
>>>> Maybe a first step could be to change qemu-img so that it refuses to
>>>> create new qcow1 images (but still can convert them into other formats).
>>>> So basically make qcow1 read-only?
>>>
>>> Yep, and the actual first step to that is to make it issue a deprecation
>>> warning when creating qcow v1 images (which is what I proposed). :-)
>>>
>>> Max
>>>
>>
>> Deprecation warning is good.
>>
>> In future versions you can shimmy it behind a
>> --no-really-I-want-this-old-format option, I think we ought to support
>> creating the images for as long as is technologically convenient.
> 
> Well, at some point you can also demand from users to just dig out some
> old version of qemu-img to convert their qcow v1 images to qcow2.  It's
> not like they are going to miss out on anything.
> 

As long is convenient. I won't throw a fit that it needs to be around
forever, but as long as it's sufficiently guarded from use and isn't
hard to keep around I'd prefer to do that.

I suppose it's just a weak preference.

> (If you deprecate emulated hardware, users may complain that they don't
> get the newest qemu features/bugfixes/... while continuing to use that
> hardware, so I can see that it's a tough decision whether to deprecate
> that.  But it's not like you are going to lose any features or anything
> if you convert your dusty images to qcow2.  On the contrary, we're
> helping you to get more performance out of them.  Maybe qemu should just
> silently convert qcow v1 images to qcow2 without asking the user, like
> Apple did...)
> 
> Max
> 

"Like Apple did" seems sufficient justification to never do that, but
maybe that's just my own opinion.
