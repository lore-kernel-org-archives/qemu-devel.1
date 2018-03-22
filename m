Received: from eggs.gnu.org ([2001:4830:134:3::10]:46558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ez0UH-0001co-83
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ez0UB-0005S0-Mk
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:42:37 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:57422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1ez0UB-0005P5-9b
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:42:31 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <297790d0-cac0-8609-7516-d6025b4759a8@redhat.com>
References: <cover.1521717086.git.berto@igalia.com>
	<cb7dcdf3685e430783b24cce3a3cbd3aaa997cb7.1521717086.git.berto@igalia.com>
	<297790d0-cac0-8609-7516-d6025b4759a8@redhat.com>
Date: Thu, 22 Mar 2018 14:42:27 +0100
Message-ID: <w51sh8sdy64.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 2/2] iotests: Update 186 after
 commit ac64273c66ab136c44043259162
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Thu 22 Mar 2018 02:17:23 PM CET, Eric Blake wrote:
>> --- a/tests/qemu-iotests/186.out
>> +++ b/tests/qemu-iotests/186.out
>> @@ -404,7 +404,7 @@ Testing: -drive if=floppy
>>   QEMU X.Y.Z monitor - type 'help' for more information
>>   (qemu) info block
>>   floppy0: [not inserted]
>> -    Attached to:      /machine/unattached/device[17]
>> +    Attached to:      /machine/unattached/device[13]
>
> It looks like this name is quite flexible; would it not be better to
> enhance 186 to sed out the name (s/Attached to:.*/Attached to: PATH/)
> and then adjust the .out so that it is no longer sensitive to these
> types of internal renames?

That's a good idea, shall we hide the number only?  (i.e. leave
"/machine/unattached/device[INDEX]" or something like that), or can the
rest of the path also change?

Berto
