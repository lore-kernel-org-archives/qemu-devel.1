Received: from eggs.gnu.org ([2001:4830:134:3::10]:43467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXlJ4-0000fA-QI
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXlIz-0002xR-4H
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:06:57 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:40965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gXlIx-0002t7-8V
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:06:52 -0500
References: <20181212102548.27626-1-alex.bennee@linaro.org>
	<807c60e6-2a76-d7e4-6cbf-ef305b784ce7@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9807a1e9-de66-fff1-d1cc-dd0fe45d5f23@vivier.eu>
Date: Fri, 14 Dec 2018 12:06:42 +0100
MIME-Version: 1.0
In-Reply-To: <807c60e6-2a76-d7e4-6cbf-ef305b784ce7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, maxim.kuvyrkov@linaro.org

On 14/12/2018 11:51, Philippe Mathieu-Daudé wrote:
> On 12/12/18 11:25 AM, Alex Bennée wrote:
>> This is a QEMU specific version of a gitdm config for generating
>> reports on the contributor base of the project. I've added enough
>> group maps and domain aliases to ensure the current top ten is as
>> reflective as it can be. As of this commit running:
>>
>>   git log --numstat --since "Last Year" | gitdm -n -l 10
>>
>> Reports:
>>
>>   Top changeset contributors by employer
>>   Red Hat                   3126 (44.0%)
>>   Linaro                    1166 (16.4%)
>>   (None)                     684 (9.6%)
>>   IBM                        348 (4.9%)
>>   Virtuozzo                  168 (2.4%)
>>   Xilinx                     102 (1.4%)
>>   Wave Computing             101 (1.4%)
>>   Igalia                      93 (1.3%)
>>   Cadence Design Systems      88 (1.2%)
>>   SiFive                      59 (0.8%)
>>
>>   Top lines changed by employer
>>   Red Hat                   143166 (27.9%)
>>   Cadence Design Systems    126554 (24.6%)
>>   Linaro                    78845 (15.3%)
>>   Wave Computing            32263 (6.3%)
>>   (None)                    21789 (4.2%)
>>   SiFive                    14392 (2.8%)
>>   IBM                       12219 (2.4%)
>>   Virtuozzo                 10445 (2.0%)
>>   CodeWeavers               9179 (1.8%)
>>   Xilinx                    4572 (0.9%)
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - use aliases instead of .mailmap
>>   - add more companies to domainmap
>>   - add more groups to cover non-corporate email
>>   - add an individuals group-map for (None)
>>   - limit the stats to top ten
>> ---
>>  contrib/gitdm/aliases               |  27 +++
>>  contrib/gitdm/domain-map            |  18 ++
>>  contrib/gitdm/filetypes.txt         | 362 ++++++++++++++++++++++++++++
>>  contrib/gitdm/group-map-cadence     |   3 +
>>  contrib/gitdm/group-map-codeweavers |   1 +
>>  contrib/gitdm/group-map-ibm         |   6 +
>>  contrib/gitdm/group-map-redhat      |   7 +
>>  contrib/gitdm/group-map-wavecomp    |   9 +
>>  gitdm.config                        |  48 ++++
>>  9 files changed, 481 insertions(+)
>>  create mode 100644 contrib/gitdm/aliases
>>  create mode 100644 contrib/gitdm/domain-map
>>  create mode 100644 contrib/gitdm/filetypes.txt
>>  create mode 100644 contrib/gitdm/group-map-cadence
>>  create mode 100644 contrib/gitdm/group-map-codeweavers
>>  create mode 100644 contrib/gitdm/group-map-ibm
>>  create mode 100644 contrib/gitdm/group-map-redhat
>>  create mode 100644 contrib/gitdm/group-map-wavecomp
>>  create mode 100644 gitdm.config
>>
...
>> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
>> new file mode 100644
>> index 0000000000..252742d131
>> --- /dev/null
>> +++ b/contrib/gitdm/group-map-redhat
>> @@ -0,0 +1,7 @@
>> +#
>> +# RedHat contributors using non-corporate email
>> +#
>> +
>> +david@gibson.dropbear.id.au
>> +laurent@vivier.eu
> 
> Cc'ing Laurent, I understood he manages the commit signed under his
> personal email during his hobbyist time.

You're right, but with time all is really mixed now and we can keep
Alex' patch as-is.

Thanks,
Lauren
