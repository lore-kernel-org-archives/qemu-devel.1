Received: from eggs.gnu.org ([2001:4830:134:3::10]:49355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Tg-0006lI-5w
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Tc-0002nh-9O
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3Tc-0002m4-0Q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:36:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-28-git-send-email-armbru@redhat.com>
	<370b0db7-c576-265e-c4ab-aad5c0146d3d@redhat.com>
Date: Wed, 15 Mar 2017 08:36:04 +0100
In-Reply-To: <370b0db7-c576-265e-c4ab-aad5c0146d3d@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 14:36:15 -0500")
Message-ID: <87wpbrq9ej.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 27/47] qapi2texi: Generate
 documentation for variant members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> A flat union's branch brings in the members of another type.  Generate
>> a suitable reference to that type.
>> 
>> Example change (qemu-qmp-ref.txt):
>> 
>>   -- Flat Union: QCryptoBlockOpenOptions
>> 
>>       The options that are available for all encryption formats when
>>       opening an existing volume
>> 
>>       Members:
>>       The members of 'QCryptoBlockOptionsBase'
>> +     The members of 'QCryptoBlockOptionsQCow' when 'format' is "qcow"
>
> Relies on the implied knowledge that 'format' is a member of
> 'QCryptoBlockOptionsBase'. Does that mean references to another type
> might usefully want to do a list of member names, to avoid having to
> follow the hyperlink, while still leaving the hyperlink when searching

Apropos link: 'format' in 'format is "qcow" could be made one.

> for full details on that member?  As in:
>
> Members:
> The members of 'QCryptoBlockOptionsBase' ('format')
> The members of 'QCryptoBlockOptionsQCow' when 'format' is "qcow"
> ('key-secret')
>
> But it could get noisy (the example here only adds one member; other
> unions add lots of members), and I'm also okay if you don't like the
> idea or would rather do it as a followup.

I figure more than a few members would be too noisy.  Which ones to omit
then?  I'm open to ideas, but it needs to be done as a follow-up, to
give us a chance to fix the QMP documentation regression in time for
2.9.

>> +     The members of 'QCryptoBlockOptionsLUKS' when 'format' is "luks"
>> 
>>       Since: 2.6
>> 
>> A simple union's branch adds a member 'data' of some other type.
>> Generate documentation for that member.
>> 
>> Example change (qemu-qmp-ref.txt):
>> 
>>   -- Simple Union: SocketAddress
>> 
>>       Captures the address of a socket, which could also be a named file
>>       descriptor
>> 
>>       Members:
>>       'type'
>> 	   Not documented
>> +     'data: InetSocketAddress' when 'type' is "inet"
>> +     'data: UnixSocketAddress' when 'type' is "unix"
>> +     'data: VsockSocketAddress' when 'type' is "vsock"
>> +     'data: String' when 'type' is "fd"
>
> Looks reasonable.
>
>> 
>>       Since: 1.3
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi2texi.py | 27 ++++++++++++++++++++-------
>>  1 file changed, 20 insertions(+), 7 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
