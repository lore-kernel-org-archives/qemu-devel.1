Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpEIy-00056L-UJ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpEIy-0007PL-6C
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:58:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpEIy-0007PB-0B
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:58:48 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-26-armbru@redhat.com>
	<d20bd7f2-8398-2eec-8b24-5386115c77ba@redhat.com>
	<87k1oubvb1.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f213cfd9-ec73-5ecd-547d-fff872f505b2@redhat.com>
Date: Mon, 13 Aug 2018 09:58:46 -0500
MIME-Version: 1.0
In-Reply-To: <87k1oubvb1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 25/56] json: Leave rejecting invalid escape
 sequences to parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/13/2018 02:05 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>>> Both lexer and parser reject invalid escape sequences in strings.  The
>>> parser's check is useless.
>>>

>>> + * Extensions over RFC 7159:
>>> + * - Extra escape sequence in strings:
>>> + *   0x27 (apostrophe) is recognized after escape, too
>>> + * - Single-quoted strings:
>>> + *   Like double-quoted strings, except they're delimited by %x27
>>> + *   (apostrophe) instead of %x22 (quotation mark), and can't contain
>>> + *   unescaped apostrophe, but can contain unescaped quotation mark.
>>> + *
>>> + * Note:
>>> + * - Encoding is modified UTF-8.
>>
>> That is an extension over RFC 7159. But I'm okay with leaving it in
>> the Notes section.
>>
>>> + * - Invalid Unicode characters are rejected.
>>> + * - Control characters are rejected by the lexer.
>>
>> Worth being explicit that this is 00-1f, fe, and ff?
> 
> \xFE and \xFF are invalid, not control.
> 
> What about:
> 
>   * - Invalid Unicode characters are rejected.
>   * - Control characters \x00..\x1F are rejected by the lexer.

Works for me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
