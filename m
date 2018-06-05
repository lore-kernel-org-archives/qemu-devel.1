Received: from eggs.gnu.org ([2001:4830:134:3::10]:55518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQIGn-0005zL-Da
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQIGm-0004Zl-Gu
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:09:29 -0400
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<20180605190324.GA11372@localhost.localdomain>
	<20180605223934-mutt-send-email-mst@kernel.org>
	<a9fdbe0f-2c39-7da3-11f2-6752b74cce08@redhat.com>
	<20180605195855.GC1455@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f6ecbb5-3175-44d0-5922-b13ac163f006@redhat.com>
Date: Tue, 5 Jun 2018 15:09:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180605195855.GC1455@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/05/2018 02:58 PM, Richard W.M. Jones wrote:
>> Binary blobs can always be base64 encoded for representation within
>> a valid JSON UTF-8 string (and we already have several QMP
>> interfaces that utilize base64 encoding to pass through what is
>> otherwise invalid UTF-8).  It does inflate things slightly compared
>> to a format that allows a raw length coupled with raw data, but that
>> is not necessarily a problem.
> 
> Of course how we represent them externally and/or while
> using QMP / qemu-img to store and retrieve them is up for grabs.
> Doesn't JSON allow binary to be encoded?  (Knowing how poorly
> done JSON is, I wouldn't be surprised if not)

JSON itself does not have a binary primitive; to pass arbitrary data 
through JSON you have to first encode that data into something like 
base64 that can then be represented as a UTF-8 string.  For reference, 
look at qapi/crypto.json and the definition of QCryptoSecretFormat.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
