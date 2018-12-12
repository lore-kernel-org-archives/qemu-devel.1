Received: from eggs.gnu.org ([2001:4830:134:3::10]:46131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gX1L7-0003b6-1N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gX1L1-0003QO-9f
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:02:00 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gX1L1-0003PR-2o
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:01:55 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so16972041wrt.13
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 02:01:55 -0800 (PST)
References: <20181211174253.10947-1-alex.bennee@linaro.org>
	<81aec30a-c599-9521-9571-c32de4087db4@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <81aec30a-c599-9521-9571-c32de4087db4@redhat.com>
Date: Wed, 12 Dec 2018 10:01:52 +0000
Message-ID: <87pnu712sv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, maxim.kuvyrkov@linaro.org, =?utf-8?Q?C=C3=A9dri?= =?utf-8?Q?c?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>


Thomas Huth <thuth@redhat.com> writes:

> On 2018-12-11 18:42, Alex Benn=C3=A9e wrote:
>> This is a QEMU specific version of a gitdm config for generating
>> reports on the contributor base of the project. I've added enough
>> group maps and domain aliases to ensure the current top ten is as
>> reflective as it can be. As of this commit running:
>>
>>   git log --numstat --since "Last Year" | gitdm -n -l 16
>>
>> Reports:
>>
>>   Top changeset contributors by employer
>>   RedHat                    3116 (43.8%)
>>   Linaro                    1166 (16.4%)
>>   f4bug@amsat.org            384 (5.4%)
>>   IBM                        170 (2.4%)
>>   Virtuozzo                  168 (2.4%)
>>   mark.cave-ayland@ilande.co.uk  161 (2.3%)
>>   cota@braap.org             134 (1.9%)
>>   Xilinx                     102 (1.4%)
>>   clg@kaod.org               100 (1.4%)
>>   Igalia                      93 (1.3%)
>>   Cadence Design Systems      88 (1.2%)
>>   groug@kaod.org              78 (1.1%)
>
> You might also want to add a group-map-ibm file for groug and
> clg@kaod.org ?

Yes I finally tracked that down via what I presume are their github ids.
The domain itself has a rather enigmatic but sparse homepage ;-)

>
>  Thomas


--
Alex Benn=C3=A9e
