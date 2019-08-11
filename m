Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A13DC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 06:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345D6208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 06:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345D6208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwgzw-0002iw-Fc
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 02:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hwgzN-0002Iy-Ki
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hwgzL-0008DN-Lb
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:05:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hwgzL-0008CU-DN
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 02:05:55 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7B624wd052071
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2019 02:05:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uab8taxam-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2019 02:05:53 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Sun, 11 Aug 2019 07:05:50 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 11 Aug 2019 07:05:49 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7B65mnC31260804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 11 Aug 2019 06:05:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 376AB4C046;
 Sun, 11 Aug 2019 06:05:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 128C64C04E;
 Sun, 11 Aug 2019 06:05:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.2.246])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 11 Aug 2019 06:05:44 +0000 (GMT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-7-bala24@linux.ibm.com>
 <7d1b2fd4-aa95-06aa-1d69-fadc77921fb3@redhat.com>
From: Balamuruhan S <bala24@linux.ibm.com>
Date: Sun, 11 Aug 2019 11:35:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7d1b2fd4-aa95-06aa-1d69-fadc77921fb3@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081106-0020-0000-0000-0000035E6128
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081106-0021-0000-0000-000021B36CDD
Message-Id: <770038a7-22e9-c2da-0f98-b47849d3f182@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-11_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908110068
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] hw/ppc/pnv_homer: add python
 interface support for homer/occ common area
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, hari@linux.vnet.ibm.com,
 clg@kaod.org, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8/7/19 3:57 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/7/19 9:14 AM, Balamuruhan S wrote:
>> use python interface APIs in homer/occ common area emulation to
>> interact with scripts if provided else fallback to normal flow,
>> it shows how simple to use the interface to call python methods
>> with any number of arguments in any script placed in common
>> -module-path provided in qemu commandline.
>>
>> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
>> ---
>>  hw/ppc/pnv_homer.c      | 20 ++++++++++++++++++++
>>  hw/ppc/pnv_xscom.c      |  9 +++++----
>>  include/sysemu/sysemu.h |  4 ++++
>>  vl.c                    | 24 ++++++++++++++++++++++++
>>  4 files changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
>> index 73a94856d0..6ae5e74f19 100644
>> --- a/hw/ppc/pnv_homer.c
>> +++ b/hw/ppc/pnv_homer.c
>> @@ -16,7 +16,9 @@
>>   * You should have received a copy of the GNU Lesser General Public
>>   * License along with this library; if not, see <http://www.gnu.org/l=
icenses/>.
>>   */
>> +#include "sysemu/python_api.h"
>>  #include "qemu/osdep.h"
>> +#include "sysemu/sysemu.h"
>>  #include "sysemu/hw_accel.h"
>>  #include "sysemu/cpus.h"
>>  #include "hw/ppc/pnv.h"
>> @@ -37,6 +39,15 @@ static bool core_max_array(hwaddr addr)
>> =20
>>  static uint64_t homer_read(void *opaque, hwaddr addr, unsigned width)
>>  {
>> +    if (homer_module && homer) {
>> +        uint64_t homer_ret;
>> +        char **address =3D g_malloc(sizeof(uint64_t));
>> +        python_args_init_cast_long(address, addr, 0);
>> +        homer_ret =3D python_callback_int(module_path, homer_module, =
homer, address, 1);
>> +        python_args_clean(address, 1);
>> +        g_free(address);
> Maybe the heap overhead can be simplified alloc'ing in the PnvChip
> structure.

But it also depends on with how many arguments that we need to call pytho=
n

functions associated with read/write ops. sure, I will check the way to

adopt this suggestion.

Thanks Philippe.


>
>> +        return homer_ret;
>> +    }
>>      switch (addr) {
>>          case 0xe2006:  /* max pstate ultra turbo */
>>          case 0xe2018:  /* pstate id for 0 */
>> @@ -106,6 +117,15 @@ const MemoryRegionOps pnv_homer_ops =3D {
>> =20
>>  static uint64_t occ_common_area_read(void *opaque, hwaddr addr, unsig=
ned width)
>>  {
>> +    if (occ_module && occ) {
>> +        uint64_t occ_ret;
>> +        char **address =3D g_malloc(sizeof(uint64_t));
>> +        python_args_init_cast_long(address, addr, 0);
>> +        occ_ret =3D python_callback_int(module_path, occ_module, occ,=
 address, 1);
>> +        python_args_clean(address, 1);
>> +        g_free(address);
>> +        return occ_ret;
>> +    }
>>      switch (addr) {
>>          /*
>>           * occ-sensor sanity check that asserts the sensor
>> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
>> index 18a780bcdf..5e41b7c953 100644
>> --- a/hw/ppc/pnv_xscom.c
>> +++ b/hw/ppc/pnv_xscom.c
>> @@ -179,13 +179,14 @@ static uint64_t xscom_read(void *opaque, hwaddr =
addr, unsigned width)
>>      MemTxResult result;
>> =20
>>      if (xscom_module && xscom_readp) {
>> -        char **args =3D g_malloc(2 * sizeof(uint64_t));
>> +        char **args =3D g_malloc(3 * sizeof(uint64_t));
>>          PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>>          python_args_init_cast_long(args, pcba, 0);
>> -        python_args_init_cast_int(args, pcc->chip_type, 1);
>> +        python_args_init_cast_int(args, chip->chip_num, 1);
>> +        python_args_init_cast_int(args, pcc->chip_type, 2);
>>          val =3D python_callback_int(module_path, xscom_module, xscom_=
readp,
>> -                                  args, 2);
>> -        python_args_clean(args, 2);
>> +                                  args, 3);
>> +        python_args_clean(args, 3);
>>          g_free(args);
>>      }
>>      else {
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 9b8dc346d6..3c8119e040 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -121,6 +121,10 @@ extern const char *module_path;
>>  extern const char *xscom_module;
>>  extern const char *xscom_readp;
>>  extern const char *xscom_writep;
>> +extern const char *homer_module;
>> +extern const char *homer;
>> +extern const char *occ_module;
>> +extern const char *occ;
>>  extern int mem_prealloc;
>> =20
>>  #define MAX_NODES 128
>> diff --git a/vl.c b/vl.c
>> index 28f0dc1c1b..c96d35d907 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -144,6 +144,10 @@ const char *module_path =3D NULL;
>>  const char *xscom_module =3D NULL;
>>  const char *xscom_readp =3D NULL;
>>  const char *xscom_writep =3D NULL;
>> +const char *homer_module =3D NULL;
>> +const char *homer =3D NULL;
>> +const char *occ_module =3D NULL;
>> +const char *occ =3D NULL;
>>  int mem_prealloc =3D 0; /* force preallocation of physical target mem=
ory */
>>  bool enable_mlock =3D false;
>>  bool enable_cpu_pm =3D false;
>> @@ -495,6 +499,22 @@ static QemuOptsList qemu_module_opts =3D {
>>              .name =3D "xscom_write",
>>              .type =3D QEMU_OPT_STRING,
>>          },
>> +        {
>> +            .name =3D "homer_module",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>> +        {
>> +            .name =3D "homer",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>> +        {
>> +            .name =3D "occ_module",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>> +        {
>> +            .name =3D "occ",
>> +            .type =3D QEMU_OPT_STRING,
>> +        },
>>          { /* end of list */ }
>>      },
>>  };
>> @@ -3231,6 +3251,10 @@ int main(int argc, char **argv, char **envp)
>>                  xscom_module =3D qemu_opt_get(opts, "xscom_module");
>>                  xscom_readp =3D qemu_opt_get(opts, "xscom_read");
>>                  xscom_writep =3D qemu_opt_get(opts, "xscom_write");
>> +                homer_module =3D qemu_opt_get(opts, "homer_module");
>> +                homer =3D qemu_opt_get(opts, "homer");
>> +                occ_module =3D qemu_opt_get(opts, "occ_module");
>> +                occ =3D qemu_opt_get(opts, "occ");
>>                  break;
>>              case QEMU_OPTION_mem_prealloc:
>>                  mem_prealloc =3D 1;
>>
